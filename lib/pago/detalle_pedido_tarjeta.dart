import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:water_buy/noficaciones.dart';
import 'package:water_buy/pago/pago_tajeta.dart';
import 'package:water_buy/perfil.dart';
import '../detalle_pedido_perfil.dart';
import '../menu_producto.dart';
import 'package:flutter/services.dart';

class DetallePedidoTarjeta extends StatefulWidget {
  final int idPedido;
  const DetallePedidoTarjeta({Key? key, required this.idPedido}) : super(key: key);

  @override
  State<DetallePedidoTarjeta> createState() => _DetallePedidoTarjetaState();
}

class _DetallePedidoTarjetaState extends State<DetallePedidoTarjeta> {
  int myIndex = 0;
  int counter = 0;
  String selectedOption = 'Tipo de Pago'; // Opción seleccionada inicialmente

  TextEditingController _nombreTitularController = TextEditingController();
  TextEditingController _fechaExpiracionController = TextEditingController();
  TextEditingController _ccvController = TextEditingController();

  bool _isLoading = false;
  bool _showSuccessArrow = false;
  int pedidosRealizados = 0;
  List<int> listaPedidos = [];
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
          'Pago con Tarjeta',
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
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        children: [
          Column(
            children: [
              Image.network(
                'https://e7.pngegg.com/pngimages/613/876/png-clipart-debit-card-product-brand-credit-card-id-cards-blue-chip.png',
                height: 170,
              ),
              const SizedBox(height: 30),
              const Text(
                "Agrega tu tarjeta",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nombreTitularController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Rodrigo Morales',
                  labelText: 'Ingresa tu nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(width: 1.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _fechaExpiracionController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'MM/YY',
                        labelText: 'Fecha de Expiración',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(width: 1.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _ccvController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: '686',
                        labelText: 'CCV',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(width: 1.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? CircularProgressIndicator()
                  : MaterialButton(
                      onPressed: _validarPago,
                      color: const Color.fromARGB(255, 0, 68, 123),
                      elevation: 5,
                      minWidth: 200,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Pagar',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
              if (_showSuccessArrow)
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _validarPago() {
    String nombreTitular = _nombreTitularController.text.trim();
    String fechaExpiracion = _fechaExpiracionController.text.trim();
    String ccv = _ccvController.text.trim();

    if (nombreTitular.isEmpty || fechaExpiracion.isEmpty || ccv.isEmpty) {
      Fluttertoast.showToast(msg: 'Completa todos los campos');
      return;
    }

    // Simula el proceso de pago con un retraso de 2 segundos
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _showSuccessArrow = true;

        // Muestra la flecha de éxito por 2 segundos
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _showSuccessArrow = false;

            // Si todos los campos están completos, procede con el pago.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PagoTarjeta(idPedido: widget.idPedido)),
            );
          });
        });
      });
    });
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

  void _showSuccessArrowDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pago Exitoso'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40,
              ),
              const SizedBox(height: 20),
              const Text('¡El pago se realizó con éxito!'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Redirige a otra página después de que se cierre el AlertDialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetallePedido(idPedido: 1,)),
                );
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}

// Esta es la página a la que se redirige después de que se presiona "Aceptar" en el AlertDialog

