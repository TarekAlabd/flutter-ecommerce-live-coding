import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/controllers/auth/auth_cubit.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: BlocConsumer<AuthCubit, AuthState>(
              bloc: authCubit,
              listenWhen: (previous, current) =>
                  current is AuthFailed || current is AuthInitial,
              listener: (context, state) {
                if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                } else if (state is AuthInitial) {
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed(AppRoutes.loginPageRoute);
                }
              },
              buildWhen: (previous, current) =>
                  current is AuthLoading ||
                  current is AuthInitial ||
                  current is AuthFailed,
              builder: (context, state) {
                if (state is AuthLoading) {
                  return MainButton(
                    child: const CircularProgressIndicator.adaptive(),
                  );
                }
                return MainButton(
                  text: 'Log Out',
                  onTap: () async {
                    await authCubit.logout();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
