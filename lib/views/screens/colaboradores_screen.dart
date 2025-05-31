import 'package:flutter/material.dart';
import 'package:poseidon_delivery/viewmodel/colaboradores_viewmodel.dart';
import 'package:provider/provider.dart';
import '../components/header.dart';

class ColaboradoresScreen extends StatefulWidget {
  const ColaboradoresScreen({super.key});

  @override
  State<ColaboradoresScreen> createState() => _ColaboradoresScreenState();
}

class _ColaboradoresScreenState extends State<ColaboradoresScreen> {
  final _enderecoController = TextEditingController();
  String? _transportadoraSelecionada;

  @override
  Widget build(BuildContext context) {
    final colaboradores = context.watch<ColaboradoresViewModel>();
    final pedidoPendente = colaboradores.pedidoPendente;

     return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  const Text(
                    'Pedidos para Entrega',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  if (pedidoPendente != null)
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Adicionar endereço de entrega:'),
                            TextField(
                              controller: _enderecoController,
                              decoration: const InputDecoration(hintText: 'Digite seu endereço'),
                            ),
                            const SizedBox(height: 12),
                            const Text('Escolha a transportadora:'),
                            DropdownButton<String>(
                              value: _transportadoraSelecionada,
                              items: const [
                                DropdownMenuItem(value: 'Hermes', child: Text('Hermes (1 dia - expresso)')),
                                DropdownMenuItem(value: 'Pegasus', child: Text('Pegasus (2 dias - rápido)')),
                                DropdownMenuItem(value: 'Adrasteia', child: Text('Adrasteia (7 dias - normal)')),
                              ],
                              onChanged: (val) {
                                setState(() => _transportadoraSelecionada = val);
                              },
                              hint: const Text('Selecione a transportadora'),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: (_enderecoController.text.isNotEmpty && _transportadoraSelecionada != null)
                                  ? () {
                                      colaboradores.completarUltimoPedido(
                                        endereco: _enderecoController.text,
                                        transportadora: _transportadoraSelecionada!,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Pedido enviado para entrega!')),
                                      );
                                      _enderecoController.clear();
                                      setState(() => _transportadoraSelecionada = null);
                                    }
                                  : null,
                              child: const Text('Enviar para entrega'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (colaboradores.pedidos.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('Nenhum pedido finalizado ainda.'),
                    )
                  else
                    ...colaboradores.pedidos
                        .where((pedido) => pedido.endereco.isNotEmpty && pedido.transportadora.isNotEmpty)
                        .map((pedido) => Card(
                              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              child: ListTile(
                                title: Text("Produtos: ${pedido.produtos.join(', ')}"),
                                subtitle: Text(
                                  'Total: R\$${pedido.total.toStringAsFixed(2)}\n'
                                  'Endereço: ${pedido.endereco}\n'
                                  'Transportadora: ${pedido.transportadora}\n'
                                  'Data: ${pedido.data.day}/${pedido.data.month}/${pedido.data.year}',
                                ),
                              ),
                            )),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(),
          ),
        ],
      ),
    );
  }
}