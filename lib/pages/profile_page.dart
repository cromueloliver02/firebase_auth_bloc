import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../blocs/auth/auth_bloc.dart';
import '../cubits/cubits.dart';
import '../models/user_model.dart';
import '../utils/utils.dart';

class ProfilePage extends StatefulWidget {
  static const id = '/profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() {
    final uid = context.read<AuthBloc>().state.user!.uid;
    context.read<ProfileCubit>().getProfile(uid);
  }

  void _profileListener(BuildContext ctx, ProfileState state) {
    if (state.status == ProfileStatus.error) {
      showErrorDialog(ctx, state.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: _profileListener,
        builder: (ctx, state) {
          if (state.status == ProfileStatus.initial) {
            return const SizedBox.shrink();
          }

          if (state.status == ProfileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == ProfileStatus.error) {
            return const _ErrorMessage();
          }

          final user = state.user;

          return _ProfileDetails(user: user);
        },
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  const _ProfileDetails({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: user.profileImage,
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const Text(
            'Profile Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(
              Icons.fingerprint,
              size: 30,
            ),
            title: Text(user.id),
            subtitle: const Text('Account ID'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.account_circle_rounded,
              size: 30,
            ),
            title: Text(user.name),
            subtitle: const Text('Name'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.email,
              size: 30,
            ),
            title: Text(user.email),
            subtitle: const Text('Email'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.score,
              size: 30,
            ),
            title: Text('${user.point}'),
            subtitle: const Text('Points'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.emoji_events,
              size: 30,
            ),
            title: Text(user.rank.titleCase),
            subtitle: const Text('Rank'),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/error.png',
            width: 75,
            height: 75,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const Text(
            'Ooops!\nTry again',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
