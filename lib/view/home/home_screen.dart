import 'package:flutter/material.dart';
import 'package:mvvm_architechture_provider_http/res/app_context_extention.dart';
import 'package:provider/provider.dart';

import '../../data/remote/response/Status.dart';
import '../../models/movies_list/movies_main.dart';
import '../../utils/Utils.dart';
import '../../view_model/home/movies_list_vm.dart';
import '../details/movie_details_screen.dart';
import '../widget/my_error_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/my_text_view.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MoviesListVM viewModel = MoviesListVM();

  @override
  void initState() {
    viewModel.fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: MyTextView(
                context.resources.strings.homeScreen,
                context.resources.color.colorWhite,
                context.resources.dimension.bigText)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ChangeNotifierProvider<MoviesListVM>.value(
        value: viewModel,
        child: Consumer<MoviesListVM>(builder: (context, viewModel, _) {
          switch (viewModel.movieMain.status) {
            case Status.LOADING:
              print("MARAJ :: LOADING");
              return LoadingWidget();
            case Status.ERROR:
              print("MARAJ :: ERROR");
              return MyErrorWidget(viewModel.movieMain.message ?? "NA");
            case Status.COMPLETED:
              print("MARAJ :: COMPLETED");
              return _getMoviesListView(viewModel.movieMain.data?.movies);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget _getMoviesListView(List<Movie>? moviesList) {
    return ListView.builder(
        itemCount: moviesList?.length,
        itemBuilder: (context, position) {
          return _getMovieListItem(moviesList![position]);
        });
  }

  Widget _getMovieListItem(Movie item) {
    return Card(
      elevation: context.resources.dimension.lightElevation,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(
              context.resources.dimension.imageBorderRadius),
          child: Image.network(
            item.posterurl ?? "",
            errorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/img_error.png');
            },
            fit: BoxFit.fill,
            width: context.resources.dimension.listImageSize,
            height: context.resources.dimension.listImageSize,
          ),
        ),
        title: MyTextView(
            item.title ?? "NA",
            context.resources.color.colorPrimaryText,
            context.resources.dimension.bigText),
        subtitle: MyTextView(
            item.year ?? "NA",
            context.resources.color.colorSecondaryText,
            context.resources.dimension.mediumText),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextView(
                "${Utils.setAverageRating(item.ratings ?? [])}",
                context.resources.color.colorBlack,
                context.resources.dimension.mediumText),
            SizedBox(
              width: context.resources.dimension.verySmallMargin,
            ),
            Icon(
              Icons.star,
              color: context.resources.color.colorAccent,
            ),
          ],
        ),
        onTap: () {
          _sendDataToMovieDetailScreen(context, item);
        },
      ),
    );
  }

  void _sendDataToMovieDetailScreen(BuildContext context, Movie item) {
    Navigator.pushNamed(context, MovieDetailsScreen.id, arguments: item);
  }
}
