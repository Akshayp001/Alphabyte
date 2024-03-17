import 'package:flutter/material.dart';

class ExListTile extends StatefulWidget {
  var itemId;
  ExListTile(this.itemId);

  @override
  State<ExListTile> createState() => _ExListTileState();
}

class _ExListTileState extends State<ExListTile> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    // You can initialize variables or call methods here
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isExpanded ? Colors.grey.shade800 : Colors.grey.shade700,
          borderRadius: BorderRadius.circular(12),
        ),
        height: isExpanded ? 190 : 100,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            // Placeholder for ObjectName
                            'Current Diagnosis',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          // Placeholder for teamName
                          'Type',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Uploaded On :',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Nunito',
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          // Placeholder for borrowedDateTime
                          '17/03/2024',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              !isExpanded
                  ? const SizedBox(
                      height: 10,
                    )
                  : Container(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                // Placeholder for issuer name
                                "Document ID : user3241-Doc430",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                // Placeholder for borrower name
                                "Doctor ID : Doct0652",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
