import 'package:examen1/data/repository/album_repository.dart';
import 'package:examen1/data/repository/artist_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:examen1/data/cubits/artist_cubit.dart';
import 'package:examen1/data/cubits/album_cubit.dart';
import 'apiservices.dart';

import 'package:examen1/data/model/album_model.dart';
import 'package:examen1/data/model/artist_model.dart';

import 'package:examen1/data/state/artist_state.dart';
import 'package:examen1/data/state/album_state.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArtistCubit>(
          create: (context) => ArtistCubit(apiServices as ArtistRepository),
        ),
        BlocProvider<AlbumCubit>(
          create: (context) => AlbumCubit(apiServices as AlbumRepository),
        ),
      ],
      child: MaterialApp(
        title: 'MelonMix',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('MelonMix CRUD Operations'),
          ),
          body: MainScreen(),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateArtistScreen()),
            ),
            child: Text('Create Artist'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpdateAlbumScreen()),
            ),
            child: Text('Update Album'),
          ),
          // Agrega más botones para otras operaciones CRUD
        ],
      ),
    );
  }
}

class CreateArtistScreen extends StatefulWidget {
  @override
  _CreateArtistScreenState createState() => _CreateArtistScreenState();
}

class _CreateArtistScreenState extends State<CreateArtistScreen> {
  final _nameController = TextEditingController();
  final _genreController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Artist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            ElevatedButton(
              onPressed: () {
                final artist = Artist(
                  artistId: 0, // El ID se genera automáticamente
                  name: _nameController.text,
                  genre: _genreController.text,
                  bio: _bioController.text,
                );
                context.read<ArtistCubit>().createArtist(artist);
              },
              child: Text('Create Artist'),
            ),
            BlocConsumer<ArtistCubit, ArtistState>(
              listener: (context, state) {
                if (state is ArtistCreated) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Artist Created')));
                } else if (state is ArtistError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is ArtistLoading) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateAlbumScreen extends StatefulWidget {
  @override
  _UpdateAlbumScreenState createState() => _UpdateAlbumScreenState();
}

class _UpdateAlbumScreenState extends State<UpdateAlbumScreen> {
  final _albumIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _releaseDateController = TextEditingController();
  final _artistIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Album'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _albumIdController,
              decoration: InputDecoration(labelText: 'Album ID'),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _releaseDateController,
              decoration: InputDecoration(labelText: 'Release Date'),
            ),
            TextField(
              controller: _artistIdController,
              decoration: InputDecoration(labelText: 'Artist ID'),
            ),
            ElevatedButton(
              onPressed: () {
                final album = Album(
                  albumId: int.parse(_albumIdController.text),
                  title: _titleController.text,
                  releaseDate: DateTime.parse(_releaseDateController.text),
                  artistId: int.parse(_artistIdController.text),
                );
                context.read<AlbumCubit>().updateAlbum(album);
              },
              child: Text('Update Album'),
            ),
            BlocConsumer<AlbumCubit, AlbumState>(
              listener: (context, state) {
                if (state is AlbumUpdated) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Album Updated')));
                } else if (state is AlbumError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is AlbumLoading) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

