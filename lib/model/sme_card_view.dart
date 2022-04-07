// ignore_for_file: prefer_const_constructors, await_only_futures, unused_local_variable
// ignore for file: prefer_const_literals_to_create_immutables
import 'package:Seedfund/model/sme_project_info.dart';
import 'package:flutter/material.dart';

class SMECardView extends StatefulWidget {
  final coverImg;
  final projectTitle;
  final projectDescription;
  final amount;
  final deadline;

  const SMECardView(
      {Key? key,
      this.coverImg,
      this.projectTitle,
      this.projectDescription,
      this.amount,
      this.deadline})
      : super(key: key);

  @override
  State<SMECardView> createState() => _SMECardViewState();
}

class _SMECardViewState extends State<SMECardView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SMEProjectInfo(
                          coverImg: this.widget.coverImg,
                          projectTitle: this.widget.projectTitle,
                          projectDescription: this.widget.projectDescription,
                          amount: this.widget.amount,
                          deadline: this.widget.deadline,
                        )));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Ink.image(
                    image: this.widget.coverImg,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          this.widget.projectTitle,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      this.widget.projectDescription,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.monetization_on),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 6.0,
                        ),
                        child: (Text(
                          this.widget.amount,
                          style: TextStyle(fontSize: 12.0),
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.calendar_today),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 6.0,
                        ),
                        child: (Text(
                          this.widget.deadline,
                          style: TextStyle(fontSize: 12.0),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
