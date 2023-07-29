import 'package:flutter/material.dart';
import 'package:water_buy/detalle_pedido_perfil.dart';
import 'package:water_buy/admi/perfi_adm.dart';
import 'package:water_buy/repartidor/home_repartidor.dart';
import 'nofificaciones_adm.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeAdm extends StatefulWidget {
  const HomeAdm({super.key});

  @override
  State<HomeAdm> createState() => _HomeAdmState();
}

class _HomeAdmState extends State<HomeAdm> {
  int myIndex = 0;
  int counter = 0;
  int selectedPedido = -1;

  // Mapa para almacenar el repartidor seleccionado para cada pedido
  Map<int, String?> selectedRepartidores = {};
  @override
  void initState() {
    super.initState();
    getPedido();
    getRepartidores();
  }

  // Función para actualizar el repartidor seleccionado para un pedido dado
  void setSelectedRepartidor(int pedidoNumber, String? repartidor) {
    setState(() {
      selectedRepartidores[pedidoNumber] = repartidor;
    });
  }

  List<dynamic>? pedidosObtenidos;

  Future<void> getPedido() async {
    try {
      var response = await http
          .get(Uri.parse('http://localhost:3000/pedidos/getAllPedidos'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse['data']);
        setState(() {
          pedidosObtenidos = jsonResponse['data'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        setState(() {
          pedidosObtenidos = [];
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<dynamic>? repartidoresObtenidos;

  Future<void> getRepartidores() async {
    try {
      var response = await http.get(
          Uri.parse('http://localhost:3000/repartidores/obtenerRepartidores'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse['data']);
        setState(() {
          repartidoresObtenidos = jsonResponse['data'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        setState(() {
          repartidoresObtenidos = [];
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>> getClientData(idCliente) async {
    try {
      var response = await http.get(Uri.parse(
          'http://localhost:3000/clientes/verDetallesCliente/${idCliente}'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse['data']);
        return jsonResponse['data'];
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return {};
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        backgroundColor: const Color.fromARGB(255, 29, 54, 112),
        title: const Text(
          'Home Administrador',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        selectedLabelStyle: const TextStyle(
          fontSize: 13,
        ),
        iconSize: 27,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
          _navigateToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 29, 54, 112),
              size: 30,
            ),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 53, 102, 187),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.circle_notifications,
              color: Color.fromARGB(255, 29, 54, 112),
              size: 30,
            ),
            label: 'Notificaciones',
            backgroundColor: Color.fromARGB(255, 0, 68, 123),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Color.fromARGB(255, 29, 54, 112),
              size: 30,
            ),
            label: 'Perfil',
            backgroundColor: Color.fromARGB(255, 0, 68, 123),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          Column(
            children: [
              Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/perfill.png'),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HomeRepartidor()),
                              );
                            },
                            color: Color.fromARGB(255, 52, 127, 189),
                            elevation: 5,
                            minWidth: 200,
                            height: 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Agregar repartidor',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Pedidos:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 30,
              ),
              if (pedidosObtenidos != null && pedidosObtenidos!.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pedidosObtenidos!.length,
                  itemBuilder: (context, index) {
                    final pedido = pedidosObtenidos![index];
                    return buildPedidoDropdown(index, pedido);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPedidoDropdown(int pedidoNumber, Map<String, dynamic> pedido) {
    final String? repartidorSeleccionado = selectedRepartidores[pedidoNumber];

    return Center(
      child: Card(
        color: const Color.fromARGB(255, 0, 68, 123),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            // Al tocar el Card, abrimos la página de detalle del pedido correspondiente
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetallePedido(
                  idPedido: 1,
                ),
              ),
            );
          },
          child: SizedBox(
            width: 300,
            height: 250,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '#${pedido['idPedido']}',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Codigo postal: ${pedido['codigoPostal']}',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(height: 5),
                Text(
                  'Tipo de pago: ${pedido['tipoPago']}',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(height: 5),
                Text(
                  'Repartidores',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
                ),
                SizedBox(height: 5),
                DropdownButton<String?>(
                  dropdownColor: Color.fromARGB(255, 61, 99, 169),
                  value: repartidorSeleccionado,
                  onChanged: (String? value) {
                    setSelectedRepartidor(pedidoNumber, value);
                  },
                  items: [
                    null,
                    ...?repartidoresObtenidos
                        ?.map((repartidorData) =>
                            repartidorData["nombre"] as String)
                        .toList(),
                  ].map((String? repartidor) {
                    return DropdownMenuItem<String?>(
                      value: repartidor,
                      child: Text(
                        repartidor ?? 'Seleccionar repartidor',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    );
                  }).toList(),
                ),
                FutureBuilder<Map<String, dynamic>>(
                  future: getClientData(pedido['idCliente']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      Map<String, dynamic> clienteData = snapshot.data ?? {};
                      String nombreCliente =
                          clienteData['nombre'] ?? 'Nombre no disponible';

                      return Expanded(
                        // Wrap the Column with Expanded
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            // ... Rest of your existing widgets ...
                            SizedBox(height: 5),
                            Text(
                              'Nombre del cliente: $nombreCliente',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeAdm()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotifiAdm()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PerfilUserAdm()),
        );
        break;
      default:
        break;
    }
  }
}
