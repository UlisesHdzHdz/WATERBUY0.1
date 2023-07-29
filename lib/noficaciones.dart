import 'package:flutter/material.dart';
import 'package:water_buy/perfil.dart';
import 'menu_producto.dart';

class Notifi extends StatefulWidget {
  const Notifi({Key? key}) : super(key: key);

  @override
  State<Notifi> createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {
  int myIndex = 0;
    int pedidosRealizados = 0;
  int counter = 0;
   List<int> listaPedidos = [];
  String selectedOption = 'Tipo de Pago'; // Opción seleccionada inicialmente

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
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        backgroundColor: const Color.fromARGB(255, 29, 54, 112),
        title: const Text(
          'Notificaciones',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
          ),
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
            height: 30,
          ),
          Column(
            children: [
              const Center(
                child: SizedBox(
                  width: 300.0,
                  
                ),
              ),
              
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 80,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                              Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),  // Espacio entre el icono y el texto
                                  child: Icon(
                                    Icons.browse_gallery,  // Aquí puedes elegir el icono que desees
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  'Pedido en proceso',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
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
                Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 80,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                             Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),  // Espacio entre el icono y el texto
                                  child: Icon(
                                    Icons.check_sharp,  // Aquí puedes elegir el icono que desees
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  'Pedido entregado',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                       
                             SizedBox(
                            height: 5,
                          ),
                          
                             SizedBox(
                            height: 5,
                          ),
                           
                        ],
                      ),
                    ),
                  ),
                ),
              ),
             const SizedBox(height:20,),
               Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 80,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                             Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),  // Espacio entre el icono y el texto
                                  child: Icon(
                                    Icons.rocket_launch,  // Aquí puedes elegir el icono que desees
                                    color: Color.fromARGB(255, 54, 177, 244),
                                  ),
                                ),
                                Text(
                                  'Pedido en camino',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
             const SizedBox(height: 20,),
               Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 80,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                           Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),  // Espacio entre el icono y el texto
                                  child: Icon(
                                    Icons.error_outline,  // Aquí puedes elegir el icono que desees
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  'Hubo un detalle en la entrega',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MenuProducto()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Notifi()),
        );
        break;
      case 2:
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PerfilUser(pedidosRealizados: pedidosRealizados, listaPedidos: listaPedidos)),
        );
        break;
      default:
        break;
    }
  }
}
