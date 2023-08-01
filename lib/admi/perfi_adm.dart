import 'package:flutter/material.dart';
import 'package:water_buy/detalle_pedido_perfil.dart';
import 'home_adm.dart';
import 'nofificaciones_adm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PerfilUserAdm extends StatefulWidget {
  const PerfilUserAdm({super.key});

  @override
  State<PerfilUserAdm> createState() => _PerfilUserAdmState();
}

class _PerfilUserAdmState extends State<PerfilUserAdm> {
  int myIndex = 0;
  int counter = 0;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
    getPedidos();
  }

  void cargarDatosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      setState(() {
        userData = jsonDecode(userDataString);
      });
    } else {
      // Si userDataString es nulo, inicializa userData como un Map vacío
      setState(() {
        userData = {};
      });
    }
  }

  List<dynamic>? pedidosObtenidos;

  Future<void> getPedidos() async {
    try {
      var response = await http
          .get(Uri.parse('http://localhost:3000/pedidos/getAllPedidos'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        backgroundColor: const Color.fromARGB(255, 29, 54, 112),
        title: const Text(
          'Perfil Administrador',
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
                      height: 280,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/perfill.png'),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            userData?.containsKey('nombre') == true
                                ? userData!['nombre']!
                                : 'Usuario Desconocido',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            userData?.containsKey('direccion') == true
                                ? userData!['direccion']!
                                : 'Direccion Desconocida',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            userData?.containsKey('correoElectronico') == true
                                ? userData!['correoElectronico']!
                                : 'Correo electrónico no definido',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            userData?.containsKey('telefono') == true
                                ? userData!['telefono']!
                                : '9991234567',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
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
                'Pedidos Realizados:',
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
                    return _buildPedidoCard(index, pedido);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPedidoCard(int index, Map<String, dynamic> pedido) {
    return Center(
      child: Card(
        color: const Color.fromARGB(255, 0, 68, 123),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetallePedido(idPedido: pedido['idPedido'])),
            );
          },
          child: SizedBox(
            width: 300,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    '#${pedido['idPedido']}',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                Icon(
                  Icons.water_drop_outlined,
                  color: Color.fromARGB(255, 60, 186, 232),
                ),
                Text(
                  'Realizado',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
