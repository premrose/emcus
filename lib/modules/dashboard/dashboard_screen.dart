import 'package:emcus/modules/auth/bloc/auth_bloc.dart';
import 'package:emcus/modules/auth/bloc/auth_event.dart';
import 'package:emcus/modules/auth/views/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'dashboard_bloc/dashboard_bloc.dart';
import 'dashboard_bloc/dashboard_event.dart';
import 'dashboard_bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static final List<Widget> _pages = const [
    Text('Dashboard', style: TextStyle(fontSize: 24, color: Colors.white)),
    Text('Maintenance', style: TextStyle(fontSize: 24, color: Colors.white)),
    Text('Diagnostics', style: TextStyle(fontSize: 24, color: Colors.white)),
    Text('Settings', style: TextStyle(fontSize: 24, color: Colors.white)),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: SizedBox(
              height: 31,
              child: Image.asset("assets/emcus_logo.png"),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: commonSVGWidget('assets/icon_1.svg'),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFC21330), Color(0xFF940816)],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignOut());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.logout_outlined),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF1E1745),
          body: Center(
            child: _pages[context.read<DashboardBloc>().state.tabIndex],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: BottomNavigationBar(
                currentIndex: context.read<DashboardBloc>().state.tabIndex,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                selectedLabelStyle: TextStyle(height: 1.8),
                onTap: (index) {
                  context.read<DashboardBloc>().add(DashboardTabChanged(index));
                },
                items: [
                  BottomNavigationBarItem(
                    icon: commonSVGWidget('assets/icon_5.svg'),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: commonSVGWidget('assets/icon_2.svg'),
                    label: 'Maintenance',
                  ),
                  BottomNavigationBarItem(
                    icon: commonSVGWidget('assets/icon_3.svg'),
                    label: 'Diagnostics',
                  ),
                  BottomNavigationBarItem(
                    icon: commonSVGWidget('assets/icon_4.svg'),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container commonSVGWidget(imagePath) {
    return Container(
      height: 21,
      width: 21,
      decoration: BoxDecoration(image: DecorationImage(image: Svg(imagePath))),
    );
  }
}
