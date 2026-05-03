import 'dart:developer';

import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff0f0f0f),
      child: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff1f1f1f), Color(0xff0f0f0f)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=12",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Movie Explorer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Discover your next movie",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          _DrawerItem(
            icon: Icons.movie_creation_outlined,
            title: "Movies",
            color: Colors.white,
            onTap: () {
              log(" شغال يفنان");
            },
          ),

          _DrawerItem(
            icon: Icons.bookmark_border,
            title: "Watchlist",
            color: Colors.amber,
            onTap: () {
              log(" شغال يفنان");
            },
          ),

          _DrawerItem(
            icon: Icons.search,
            title: "Search",
            color: Colors.white,
            onTap: () {
              log("السيرش شغال يفنان");
            },
          ),

          _DrawerItem(
            icon: Icons.trending_up,
            title: "Trending",
            color: Colors.redAccent,
            onTap: () {
              log(" الترندج شغال يفنان");
            },
          ),

          const Spacer(),

          const Divider(color: Colors.grey),

          _DrawerItem(
            icon: Icons.settings_outlined,
            title: "Settings",
            color: Colors.white70,
            onTap: () {
              log(" السيتنج شغال يفنان");
            },
          ),

          _DrawerItem(
            icon: Icons.logout,
            title: "Logout",
            color: Colors.red,
            onTap: () {
              log(" شغال يفنان  ال لوج اوت");
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: const TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
      ),
      hoverColor: Colors.white10,
      onTap: () {
        // Navigator.pop(context);
        onTap();
      },
    );
  }
}
