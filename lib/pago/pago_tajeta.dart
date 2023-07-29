import 'package:flutter/material.dart';
import 'package:water_buy/detalle_pedido_perfil.dart';
import 'package:water_buy/noficaciones.dart';
import 'package:water_buy/perfil.dart';
import '../menu_producto.dart';


class PagoTarjeta extends StatefulWidget {
  final int idPedido;
  const PagoTarjeta({Key? key, required this.idPedido}) : super(key: key);

  @override
  State<PagoTarjeta> createState() => _PagoTarjetaState();
}

class _PagoTarjetaState extends State<PagoTarjeta> {
  int myIndex = 0;
    int pedidosRealizados = 0;
    List<int> listaPedidos = [];
  int counter = 0;
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
          'Detalle del pedido Tarjeta',
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
            height: 70,
          ),
          Column(
            children: [
             const SizedBox(height:30,),
              const Text('Pedido Confirmado',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),),
            const SizedBox(height: 20,),
             const CircleAvatar(backgroundImage: NetworkImage('https://us.123rf.com/450wm/kritchanut/kritchanut1612/kritchanut161200066/66464630-reutilizable-de-compras-de-papel-icono-de-vector-bolsa-en-el-c%C3%ADrculo-de-color-verde-claro.jpg?ver=6'), maxRadius: 100,),
              const SizedBox(height: 50,),
               MaterialButton(
               onPressed: () {
                   Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => DetallePedido(idPedido: widget.idPedido)),
                );
                },
               color: const Color.fromARGB(255, 0, 68, 123),
               elevation: 5,
              minWidth: 200,
               height: 50,
              shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20),
               ),
             child: const Text(
                  'Finalizar',
             style: TextStyle(color: Colors.white, fontSize: 18),
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
