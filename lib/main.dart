import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_finances/model/progress_model.dart';
import 'package:my_finances/screens/auth/auth.dart';
import 'package:my_finances/screens/entrada.dart';
import 'package:my_finances/screens/saidas.dart';
import 'package:my_finances/screens/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ProgressModel(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Minhas Finanças',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => OnboardingScreen(),
        '/home': (context) => const MyHomePage(title: 'Minhas Finanças'),
        '/auth': (context) => const Auth(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      switch(index) {
        case 1: Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaEntradas('Entradas')));
        case 2: Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaSaidas('Saídas')));
      }
    });
  }

  void _goToEntradas(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaEntradas('Entradas')));
  }

  void _logOut(){
      FirebaseAuth.instance.signOut()
      .then(
        (it) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Auth())) 
    );

  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressModel>().progress;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Utilize as funcionalidades do app para progredir'),
            SizedBox(height: 10,),
            LinearProgressIndicator(
              value: progress,
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            SizedBox(height: 40,),
            Card(
              child: Text('Bem-vindo ao Minhas Finanças, aprenda a gerir o seu controle financeiro',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 25)),
            ) 
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: 
          const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(IconData(0x0024,fontFamily: 'MaterialIcons')), label: 'Entradas'),
            BottomNavigationBarItem(icon: Icon(IconData(0x0024,fontFamily: 'MaterialIcons')), label: 'Saidas')
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 73, 3, 67),
          onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 94, 22, 90)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {Navigator.pop(context);}
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () { Navigator.pop(context); }
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: _logOut
            )
          ]
        ),
      )
    );
  }
}