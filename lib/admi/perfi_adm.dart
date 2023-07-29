import 'package:flutter/material.dart';
import 'package:water_buy/detalle_pedido_perfil.dart';
import 'home_adm.dart';
import 'nofificaciones_adm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
              // Aquí puedes agregar el contenido de los pedidos realizados sin el DropdownButton
              buildPedidoCard(1),
              buildPedidoCard(2),
              buildPedidoCard(3),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPedidoCard(int pedidoNumber) {
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
            height: 100,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '#$pedidoNumber',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Pedidos',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),

                SizedBox(height: 5),
                // Aquí puedes agregar cualquier otro contenido del pedido
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
