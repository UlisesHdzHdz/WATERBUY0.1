
import 'package:flutter/material.dart';
import 'package:water_buy/login/register.dart';
import '../login/inicio_sesion.dart';

class TipoPago extends StatefulWidget {
  const TipoPago({super.key});

  @override
  State<TipoPago> createState() => _TipoPagoState();
}

class _TipoPagoState extends State<TipoPago> {
  @override
  
  Widget build(BuildContext context) {
    
    return Scaffold(
      
    backgroundColor: const Color.fromARGB(255, 51, 108, 208),
      body: ListView(
        
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 80.0,
        ),
        children: <Widget> [
          const SizedBox(height: 100,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 255, 255, 255),
                ),child:  const ClipRRect(child: Image(image: AssetImage('assets/x.png'),)),
                ),
              
             
              const SizedBox(height: 60),
             const Text("WATERBUY",
             style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 40,
              fontWeight:FontWeight.w900,
              fontFamily: 'rboldt',
              ),
            ),
             const SizedBox(height: 30,),
            const Text("Agua fresca y cristalina, directo a tu puerta.",
            textAlign: TextAlign.center,
             style: TextStyle(
              letterSpacing: 2,
             
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
              fontWeight:FontWeight.w500,
              fontFamily: 'rboldt',
              ),
            ),
            const SizedBox(height: 50,),
                MaterialButton(
                elevation: 20,
                minWidth: 200.0,
                height: 40.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                   Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => const InicioWater()),
                );
                },
                color: const Color.fromARGB(255, 16, 85, 164),
                child: const Text('Iniciar Sesión',
                 style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  )
                ),
              ),
              const SizedBox(height: 20,),
                MaterialButton(
                elevation: 20,
                minWidth: 200.0,
                height: 38.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                   Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => const  RegisterWater()),
                );
                },
                color: Colors.grey[200],
                child: const Text('Registrarse',
                 style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                  )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  
}