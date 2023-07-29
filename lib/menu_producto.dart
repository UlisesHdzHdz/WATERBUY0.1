import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_buy/pago/datos_compra.dart';
import 'package:water_buy/login/inicio.dart';
import 'noficaciones.dart';
import 'perfil.dart';

class MenuProducto extends StatefulWidget {
  const MenuProducto({super.key});

  @override
  State<MenuProducto> createState() => _MenuProductoState();
}

class _MenuProductoState extends State<MenuProducto> {
  int myIndex = 0;
  int counter = 0;
  int total = 0;
  List<int> listaPedidos = []; // Lista para almacenar los pedidos realizados

  @override
  void initState() {
    super.initState();
    _loadPedidosList();
  }

  Future<void> _loadPedidosList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedPedidos = prefs.getStringList('pedidos');
    if (savedPedidos != null) {
      setState(() {
        listaPedidos = savedPedidos.map((pedido) => int.parse(pedido)).toList();
      });
    }
  }

  Future<void> _savePedidosList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'pedidos', listaPedidos.map((pedido) => pedido.toString()).toList());
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

  int getSum() {
    // Realizar la multiplicación por 20 solo si el contador es mayor que 0
    setState(() {
      total = counter > 0 ? counter * 20 : 0;
    });
    return total;
  }

  saveInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('totalAPagar', total);
    print(total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salir',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 72, 115, 191),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // Aquí puedes definir la función de redireccionamiento al tocar el botón de flecha
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IniciOne()),
            ); // Esto regresará a la página anterior en la pila de navegación
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 80, 122, 193),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        selectedLabelStyle: const TextStyle(fontSize: 13),
        iconSize: 27,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
          _navigateToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: Color.fromARGB(255, 29, 54, 112), size: 30),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 53, 102, 187),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications,
                color: Color.fromARGB(255, 29, 54, 112), size: 30),
            label: 'Notificaciones',
            backgroundColor: Color.fromARGB(255, 0, 68, 123),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,
                color: Color.fromARGB(255, 29, 54, 112), size: 30),
            label: 'Perfil',
            backgroundColor: Color.fromARGB(255, 0, 68, 123),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0,
        ),
        children: <Widget>[
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¡Hola, Buenos días!',
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 50),
              Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const ClipRRect(
                    child: Image(image: AssetImage('assets/x.png'))),
              ),
              const SizedBox(height: 30),
              const Text(
                "Garrafón de 20 L",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'rboldt',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Agua purificada, envase de ",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'rboldt',
                  letterSpacing: 2,
                ),
              ),
              const Text(
                " de plástico con agarradera.",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'rboldt',
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                " Precio: \$20",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'rboldt',
                  letterSpacing: 3,
                ),
              ),
              Text(
                'Producto: $counter',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              // Nuevo Text para mostrar la suma solo si el contador es mayor que 0
              if (counter > 0)
                Text(
                  'Total a pagar: \$${getSum()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: Color.fromARGB(255, 21, 19, 90),
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: incrementCounter,
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(8.0)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(40.0, 40.0)),
                    ),
                    child: const Icon(Icons.add,
                        size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: decrementCounter,
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(8.0)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(40.0, 40.0)),
                    ),
                    child: const Icon(Icons.remove,
                        size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MaterialButton(
                elevation: 20,
                minWidth: 250.0,
                height: 40.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DatosCompra(),
                    ),
                  );
                  setState(() {
                    listaPedidos.add(
                        counter); // Agrega la cantidad de productos a la lista de pedidos realizados
                    _savePedidosList(); // Guarda la lista actualizada en el almacenamiento local
                  });
                  saveInstance();
                },
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    const Text(
                      'Comprar',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // ... Aquí puedes agregar cualquier otro widget que desees mostrar en el botón ...
                  ],
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
              pedidosRealizados: listaPedidos.length,
              listaPedidos: listaPedidos,
            ),
          ),
        );
        break;
      default:
        break;
    }
  }
}
