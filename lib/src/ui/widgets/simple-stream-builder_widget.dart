import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleStreamBuilder<T> extends StreamBuilder<T> {
  SimpleStreamBuilder({
    @required BuildContext context,
    @required Stream<T> stream,
    @required Widget noneChild,
    @required Widget noDataChild,
    @required Widget activeChild,
    @required Widget waitingChild,
    @required Widget unknownChild,
    String noDataMessage,
    @required Function(String) errorBuilder,
    @required Function(T) builder,
  }) : super(
            stream: stream,
            builder: (context, AsyncSnapshot<T> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return noneChild;
                  case ConnectionState.waiting:
                    return waitingChild;
                  case ConnectionState.done:
                    return activeChild;
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      if (snapshot.data is List) {
                        if ((snapshot.data as List).isEmpty)
                          return noDataChild ??
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                      child: Icon(
                                    Icons.search,
                                    size: 60,
                                  )),
                                  Center(
                                      child: Text(
                                    "No Results",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 22),
                                  )),
                                ],
                              );
                      }
                      return builder(snapshot.data);
                    } else
                      return noDataChild;
                }
              } else if (snapshot.hasError)
                return errorBuilder(snapshot.error.toString());
              return waitingChild;
            });

  SimpleStreamBuilder.simpler(
      {@required Stream<T> stream,
      @required BuildContext context,
      @required Function(T) builder})
      : this(
          context: context,
          stream: stream,
          noneChild: Text("No Connection was found"),
          noDataChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Icon(
                Icons.search,
                size: 60,
              )),
              Center(
                child: Text(
                  "No Results",
                  style: TextStyle(color: Colors.grey, fontSize: 22),
                ),
              ),
            ],
          ),
          unknownChild: Text("Unknown Error Occurred"),
          activeChild: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
            heightFactor: 10,
          ),
          waitingChild: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
            heightFactor: 10,
          ),
          errorBuilder: (String error) =>
              Align(alignment: Alignment.center, child: Text(error.toString())),
          builder: builder,
        );

  SimpleStreamBuilder.simplerSliver(
      {@required Stream<T> stream,
      @required BuildContext context,
      @required Function(T) builder})
      : this(
          context: context,
          stream: stream,
          noneChild: SliverToBoxAdapter(child: Text("No Connection was found")),
          noDataChild: SliverToBoxAdapter(child: Text("No Data was found")),
          unknownChild:
              SliverToBoxAdapter(child: Text("Unknown Error Occurred")),
          activeChild: SliverToBoxAdapter(
              child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
            heightFactor: 10,
          )),
          waitingChild: SliverToBoxAdapter(
              child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
            heightFactor: 10,
          )),
          errorBuilder: (String error) => SliverToBoxAdapter(
              child: Align(
                  alignment: Alignment.center, child: Text(error.toString()))),
          builder: builder,
        );
}
