import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/features/auth/viewmodel.dart';
import 'viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    AuthViewModel authProvider =
        Provider.of<AuthViewModel>(context, listen: false);
    String? token = authProvider.token;
    String? refresh = authProvider.refresh;
    Provider.of<HomeViewModel>(context, listen: false)
        .loadSubjects(token ?? '', refresh ?? '', authProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthViewModel>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          if (homeViewModel.authError) {
            // Redirect to login page if authentication fails
            Future.microtask(() {
              Navigator.pushReplacementNamed(context, '/login');
            });
          }
          if (homeViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: homeViewModel.subjects.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      Icons.book,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    homeViewModel.subjects[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    'Subtitle for ${homeViewModel.subjects[index]}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    // Handle tap event if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
