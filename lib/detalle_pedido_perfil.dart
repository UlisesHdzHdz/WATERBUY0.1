import 'package:flutter/material.dart';
import 'package:water_buy/noficaciones.dart';
import 'package:water_buy/perfil.dart';
import 'menu_producto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DetallePedido extends StatefulWidget {
  final int idPedido;
  const DetallePedido({
    Key? key,
    required this.idPedido,
  }) : super(key: key);

  @override
  State<DetallePedido> createState() => _DetallePedidoState();
}

class _DetallePedidoState extends State<DetallePedido> {
  int myIndex = 0;
  int counter = 0;
  Map<String, dynamic>? detallePedido;
  Map<String, dynamic>? userData;
  List<int> listaPedidos = [];
  int pedidosRealizados = 0;
  String selectedOption = 'Tipo de Pago'; // Opción seleccionada inicialmente
  Map<String, dynamic>? detalleEstado;
  Map<String, dynamic>? detalleRepartidor;

  @override
  void initState() {
    super.initState();
    getPedido();
    cargarDatosUsuario();
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  String formatDate(String date) {
    // Convertir la fecha en formato String a DateTime
    DateTime dateTime = DateTime.parse(date);

    // Formatear la fecha en el formato deseado: "día, mes y año"
    String formattedDate =
        DateFormat('dd MMMM y', 'es').format(dateTime.toLocal());

    return formattedDate;
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

  Future<void> getEstado(int idEstado) async {
    try {
      var response = await http.get(
          Uri.parse('http://localhost:3000/estados/verEstado/${idEstado}'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          detalleEstado = jsonResponse[
              'data']; // Actualiza la variable de estado con la información de response
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        // Si userDataString es nulo, inicializa userData como un Map vacío
        setState(() {
          detalleEstado = {};
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
   Future<void> getRepartidor(int idRepartidor) async {
    try {
      var response = await http.get(
          Uri.parse('http://localhost:3000/repartidores/verRepartidor/${idRepartidor}'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          detalleRepartidor = jsonResponse[
              'data']; // Actualiza la variable de estado con la información de response
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        // Si userDataString es nulo, inicializa userData como un Map vacío
        setState(() {
          detalleRepartidor = {};
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getPedido() async {
    try {
      var response = await http.get(Uri.parse(
          'http://localhost:3000/pedidos/verDetallePedido/${widget.idPedido}'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          detallePedido = jsonResponse[
              'data']; // Actualiza la variable de estado con la información de response
        });
        getEstado(detallePedido!['estado']);
        int idRepartidor = int.parse(detallePedido!['idRepartidor'].toString());
        getRepartidor(idRepartidor);
      } else {
        print('Request failed with status: ${response.statusCode}.');
        // Si userDataString es nulo, inicializa userData como un Map vacío
        setState(() {
          detallePedido = {};
        });
      }
    } catch (e) {
      print('Error: $e');
    }
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
          'Detalle del pedido',
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
              Text(
                'Pedido: #${widget.idPedido}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                detallePedido?.containsKey('fechaPedido') == true
                    ? formatDate(detallePedido!['fechaPedido']!)
                    : '2023-07-24',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: SizedBox(
                  width: 300.0,
                ),
              ),
              const SizedBox(
                height: 30,
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
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Estado:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            detalleEstado?.containsKey('descripcion') == true
                                ? detalleEstado!['descripcion']!
                                : 'Hubo un detalle al ver el estado',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
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
                    child: SizedBox(
                      width: 300,
                      height: 150,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            userData?.containsKey('direccion') == true
                                ? userData!['direccion']!
                                : 'Direccion Desconocida',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            userData?.containsKey('nombre') == true
                                ? userData!['nombre']!
                                : 'Usuario Desconocido',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            detallePedido?.containsKey('calle') == true
                                ? detallePedido!['calle']!
                                : 'Calle no definida',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            detallePedido?.containsKey('colonia') == true
                                ? detallePedido!['colonia']!
                                : 'Colonia Ilusión',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            detallePedido?.containsKey('numeroTelefono') == true
                                ? detallePedido!['numeroTelefono']!
                                : 'Numero no definido',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
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
                      height: 200,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Metodo de pago:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            detallePedido?.containsKey('tipoPago') == true
                                ? detallePedido!['tipoPago']!
                                : 'Efectivo',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Repartidor asignado:',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            detalleRepartidor?.containsKey('nombre') == true
                                ? detalleRepartidor!['nombre']!
                                : 'No hay repartidor asignado',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
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
                        height: 100,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Text(
                              'Resumen:',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '\$${detallePedido?.containsKey('total') == true ? detallePedido!['total']! : '0'}',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
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
          MaterialPageRoute(
              builder: (context) => PerfilUser(
                  pedidosRealizados: pedidosRealizados,
                  listaPedidos: listaPedidos)),
        );
        break;
      default:
        break;
    }
  }
}
