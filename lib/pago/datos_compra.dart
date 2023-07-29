import 'package:flutter/material.dart';
import 'package:water_buy/pago/pedido_efectivo.dart';
import 'package:water_buy/pago/detalle_pedido_tarjeta.dart';
import 'package:water_buy/noficaciones.dart';
import 'package:water_buy/perfil.dart';
import '../menu_producto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatosCompra extends StatefulWidget {
  const DatosCompra({Key? key}) : super(key: key);

  @override
  State<DatosCompra> createState() => _DatosCompraState();
}

class _DatosCompraState extends State<DatosCompra> {
  int myIndex = 0;
  int counter = 0;
  List<int> listaPedidos = [];
  int pedidosRealizados = 0;
  String selectedOption = 'Tipo de Pago'; // Opción seleccionada inicialmente

  final _calleController = TextEditingController();
  final _coloniaController = TextEditingController();
  final _codigoPostalController = TextEditingController();
  final _numeroController = TextEditingController();
  Map<String, dynamic>? pedidoData;
  int idPedido = 0;
  int total = 0;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarDatosUsuario();
    cargarTotal();
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

  void realizarPedido() async {
    try {
      print(userData?['idCiente']);
      var url = Uri.parse('http://localhost:3000/pedidos/realizarPedido');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'idCliente': userData?['idCliente'],
          'calle': _calleController.text,
          'estado': 1,
          'idRepartidor': 1,
          'colonia': _coloniaController.text,
          'codigoPostal': int.parse(_codigoPostalController.text),
          'numeroTelefono': _numeroController.text,
          'tipoPago': selectedOption,
          'total': total
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        bool status = jsonResponse['status'];
        String message = jsonResponse['message'];
        Map<String, dynamic>? data = jsonResponse['data'];
        pedidoData = jsonResponse['data'];
        idPedido = jsonResponse['idPedido'];

        // Aquí puedes realizar acciones en función de la respuesta del servidor
        if (status) {
          print('Pedido creado exitosamente');
          if (data != null) {
            // Manejar los datos del pedido
            print('ID Cliente: ${data['idCliente']}');
            print('Fecha Pedido: ${data['fechaPedido']}');
            // Y así sucesivamente con los demás datos del pedido
            _onPressedIrAPagar();
          }
        } else {
          print('Error: $message');
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  void cargarTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? totalInt = prefs.getInt('totalAPagar');
    print(totalInt);
    if (totalInt != null) {
      setState(() {
        total = totalInt;
      });
    } 
  }

  void _onPressedIrAPagar() {
    if (selectedOption == 'Efectivo' && pedidoData != null ) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetallePedidoEfectivo(
            idPedido: idPedido
          ),
        ),
      );
    } else if (selectedOption == 'Tarjeta') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetallePedidoTarjeta(idPedido: idPedido)),
      );
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
          'Datos de la Compra',
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
            height: 60,
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _calleController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Primavera',
                      labelText: 'Calle',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _coloniaController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Ilusion',
                      labelText: 'Colonia',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _codigoPostalController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '29150',
                      labelText: 'Codigo postal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _numeroController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '9614530515',
                      labelText: 'Numero',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                elevation: 20,
                minWidth: 250.0,
                height: 40.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuProducto()),
                  );
                },
                color: const Color.fromARGB(255, 16, 85, 164),
                child: const Text(
                  'Mi ubicacion',
                  style: TextStyle(
                    color: Color.fromARGB(255, 243, 243, 243),
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 300.0,
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    iconEnabledColor: const Color.fromARGB(255, 0, 68, 123),
                    elevation: 20,
                    iconSize: 30,
                    dropdownColor: const Color.fromARGB(255, 80, 122, 193),
                    isExpanded: true,
                    value: selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue!;
                      });
                    },
                    items: <String>[
                      'Tipo de Pago',
                      'Efectivo',
                      'Tarjeta',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              MaterialButton(
                elevation: 20,
                minWidth: 200.0,
                height: 40.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: realizarPedido,
                color: const Color.fromARGB(255, 16, 85, 164),
                child: const Text(
                  'Ir a pagar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
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
