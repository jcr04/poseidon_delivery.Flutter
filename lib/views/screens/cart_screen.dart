import 'package:flutter/material.dart';
import 'package:poseidon_delivery/viewmodel/cart_viewmodel.dart';
import 'package:poseidon_delivery/viewmodel/colaboradores_viewmodel.dart';
import 'package:poseidon_delivery/viewmodel/debito_viewmodel.dart';
import 'package:poseidon_delivery/viewmodel/pix_viwmodel.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../components/header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String paymentMethod = 'Pix';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context);
    final cartItems = cart.items;

    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Carrinho',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  if (cartItems.isEmpty)
                    const Text('Seu carrinho está vazio.'),
                  if (cartItems.isNotEmpty)
                    Column(
                      children: [
                        ...cartItems.map((item) => Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Image.asset(
                              item.product.imageUrl,
                              height: 60,
                              width: 60,
                              fit: BoxFit.contain,
                            ),
                            title: Text(item.product.name, style: const TextStyle(fontSize: 18)),
                            subtitle: Text('R\$${item.product.price.toStringAsFixed(2)}'),
                            trailing: SizedBox(
                              width: 130,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () => cart.changeQuantity(item, -1),
                                  ),
                                  Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => cart.changeQuantity(item, 1),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => cart.removeFromCart(item),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Subtotal: R\$${cart.subtotal.toStringAsFixed(2)}'),
                              Text('Frete: R\$${cart.shipping.toStringAsFixed(2)}'),
                              Text('Total: R\$${cart.total.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text('Método de Pagamento:',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        RadioListTile<String>(
                              value: 'Pix',
                              groupValue: paymentMethod,
                              onChanged: (val) {
                                setState(() => paymentMethod = val!);
                                if (val == 'Pix') {
                                  Provider.of<PixViewModel>(context, listen: false).generatePixCode();
                                }
                                Provider.of<DebitoViewModel>(context, listen: false).reset();
                              },
                              title: const Text('Pix'),
                            ),

                        if (paymentMethod == 'Pix') Consumer<PixViewModel>(
                          builder: (context, pix, _) {
                            if (pix.pixCode == null) {
                              return const SizedBox.shrink();
                            }
                            return Column(
                              children: [
                                QrImageView(
                                  data: pix.pixCode!,
                                  size: 180,
                                  backgroundColor: Colors.white,
                                ),
                                const SizedBox(height: 8),
                                SelectableText(
                                  pix.pixCode!,
                                  style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
                                ),
                                const SizedBox(height: 8),
                                if (!pix.copied && !pix.paymentSuccess)
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.copy),
                                    label: const Text('Copiar código Pix'),
                                    onPressed: () {
                                      pix.copyPixCode();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Código Pix copiado! Aguarde confirmação...')),
                                      );
                                    },
                                  ),
                                if (pix.copied && !pix.paymentSuccess)
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Processando pagamento...',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                  ),
                                if (pix.paymentSuccess)
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Pagamento Efetuado com sucesso!',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                        RadioListTile<String>(
                          value: 'Cartão',
                          groupValue: paymentMethod,
                          onChanged: (val) {
                            setState(() => paymentMethod = val!);
                            Provider.of<PixViewModel>(context, listen: false).reset();
                          },
                          title: const Text('Cartão'),
                        ),
                        if (paymentMethod == 'Cartão') ...[
                            Consumer<DebitoViewModel>(
                              builder: (context, debito, _) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Escolha o tipo:",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Radio<CardPaymentType>(
                                          value: CardPaymentType.debito,
                                          groupValue: debito.paymentType,
                                          onChanged: (val) {
                                            debito.selectPaymentType(val!);
                                            setState(() {});
                                          },
                                        ),
                                        const Text('Débito'),
                                        Radio<CardPaymentType>(
                                          value: CardPaymentType.credito,
                                          groupValue: debito.paymentType,
                                          onChanged: (val) {
                                            debito.selectPaymentType(val!);
                                            setState(() {});
                                          },
                                        ),
                                        const Text('Crédito'),
                                      ],
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(labelText: "Número do Cartão"),
                                      keyboardType: TextInputType.number,
                                      maxLength: 19,
                                      onChanged: debito.setCardNumber,
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(labelText: "Nome impresso no Cartão"),
                                      onChanged: debito.setCardHolder,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            decoration: const InputDecoration(labelText: "Validade (MM/AA)"),
                                            maxLength: 5,
                                            keyboardType: TextInputType.number,
                                            onChanged: debito.setCardExpiry,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: TextField(
                                            decoration: const InputDecoration(labelText: "CVV"),
                                            maxLength: 3,
                                            keyboardType: TextInputType.number,
                                            onChanged: debito.setCardCVV,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (debito.errorMsg != null)
                                      Text(debito.errorMsg!, style: const TextStyle(color: Colors.red)),
                                    const SizedBox(height: 12),
                                    if (debito.isProcessing)
                                      const Center(child: CircularProgressIndicator()),
                                    if (debito.isSuccess)
                                      const Center(
                                        child: Text(
                                          "Pagamento efetuado com sucesso!",
                                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    if (!debito.isProcessing && !debito.isSuccess)
                                      ElevatedButton(
                                        onPressed: debito.isCardValid
                                            ? () async {
                                                await debito.processPayment();
                                              }
                                            : null,
                                        child: const Text("Pagar"),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        const SizedBox(height: 16),
                        ElevatedButton(
                        onPressed: () {
                          final cart = Provider.of<CartViewModel>(context, listen: false);
                          final colaboradores = Provider.of<ColaboradoresViewModel>(context, listen: false);

                          colaboradores.adicionarPedido(
                            PedidoFinalizado(
                              produtos: cart.items.map((item) => item.product.name).toList(),
                              total: cart.total,
                              endereco: "",
                              transportadora: "",
                              data: DateTime.now(),
                            ),
                          );
                          cart.clear();
                          Navigator.pushNamed(context, '/colaboradores');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Compra finalizada! Preencha os dados de entrega.')),
                          );
                        },
                        child: const Text('Finalizar Compra'),
                      ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
