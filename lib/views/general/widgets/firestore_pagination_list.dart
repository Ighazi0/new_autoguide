import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/views/general/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestorePaginationList extends StatefulWidget {
  final String collection;
  final String orderByField;
  final int pageSize;
  final Widget Function(DocumentSnapshot doc) itemBuilder;

  const FirestorePaginationList({
    super.key,
    required this.collection,
    required this.orderByField,
    required this.itemBuilder,
    this.pageSize = 15,
  });

  @override
  State<FirestorePaginationList> createState() =>
      _FirestorePaginationListState();
}

class _FirestorePaginationListState extends State<FirestorePaginationList> {
  final List<DocumentSnapshot> _documents = [];
  bool _isLoading = false;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _fetchData();
      }
    });
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    Query query = FirebaseFirestore.instance
        .collection(widget.collection)
        .orderBy(widget.orderByField, descending: true)
        .limit(widget.pageSize);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
      _documents.addAll(snapshot.docs);
    }

    setState(() {
      _isLoading = false;
      if (snapshot.docs.length < widget.pageSize) {
        _hasMore = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_lastDocument == null) {
      return CustomLoading();
    }
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Durations.long1);
        setState(() {});
      },
      color: AppStyle.primaryColor,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _documents.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _documents.length) {
            return widget.itemBuilder(_documents[index]);
          } else {
            return CustomLoading();
          }
        },
      ),
    );
  }
}
