
import 'package:flutter/material.dart';
import 'package:water_buy/detalle_pedido_perfil.dart';
import 'menu_producto.dart';
import 'admi/nofificaciones_adm.dart';



class  PerfilRepartidor extends StatefulWidget {
  const  PerfilRepartidor({super.key});

  @override
  State<PerfilRepartidor> createState() => _PerfilRepartidorState();
}
class _PerfilRepartidorState extends State<PerfilRepartidor> {
    int myIndex = 0;
     int counter = 0;
    
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
      title: const Text('Perfil', 
      style: TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 20),),),
    backgroundColor: const Color.fromARGB(255, 249, 249, 249),
    bottomNavigationBar: BottomNavigationBar(
     selectedFontSize: 10,
     selectedLabelStyle: const TextStyle(fontSize: 13,),
     iconSize: 27,

    onTap: (index) {
    setState(() {
      myIndex = index;
    });
    _navigateToPage(index);
  },

  items: const [
  BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Color.fromARGB(255, 29, 54, 112), size: 30,),
      label: 'Home',
      
      backgroundColor: Color.fromARGB(255, 53, 102, 187),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.circle_notifications ,color: Color.fromARGB(255, 29, 54, 112), size: 30,),
      label: 'Notificaciones', 
    
      backgroundColor: Color.fromARGB(255, 0, 68, 123),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle ,color: Color.fromARGB(255, 29, 54, 112), size: 30,),
      label: 'Perfil',
      backgroundColor: Color.fromARGB(255, 0, 68, 123),
    ),
  ],
  
),

body:  ListView(
      children: [
       const  SizedBox(height: 60,),
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
                  child:  const SizedBox(
                    width: 300,
                    height: 280,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/perfill.png'),
                        ),
                        SizedBox(height: 15,),
                        Text('Rodrigo Morales',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),
                        SizedBox(height: 12,),
                        Text('Calle primavera, 24, Colonia Ilusión',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),
                        SizedBox(height: 4,),
                        Text('rod@gmail.com',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),
                        SizedBox(height: 4,),
                        Text('9612258643',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
             const SizedBox(height: 20,),
            const Text('Pedidos:', 
            style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w900
            ),
            ),
            const SizedBox(height: 30,),
            Center(
              child: Card(
                color: const Color.fromARGB(255, 0, 68, 123),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                      Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => const DetallePedido(idPedido: 1)),
                );
                  },
                  child:  const SizedBox(
                    width: 300,
                    height: 100,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text('#1',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),
                        SizedBox(height: 12,),
                        Text('PEDIDOS',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
             Center(
              child: Card(
                color: const Color.fromARGB(255, 0, 68, 123),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                      Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => const DetallePedido(idPedido: 1,)),
                );
                  },
                  child:  const SizedBox(
                    width: 300,
                    height: 100,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text('#2',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),
                        SizedBox(height: 12,),
                        Text('PEDIDOS',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
                Center(
              child: Card(
                color: const Color.fromARGB(255, 0, 68, 123),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                      Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => const DetallePedido(idPedido: 1,)),
                );
                  },
                  child:  const SizedBox(
                    width: 300,
                    height: 100,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text('#3',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),
                        SizedBox(height: 12,),
                        Text('PEDIDOS',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), ),
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
        MaterialPageRoute(builder: (context) => const NotifiAdm()),
      );
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PerfilRepartidor()),
      );
        
      break;
    default:
      break;
  }
}
  
}