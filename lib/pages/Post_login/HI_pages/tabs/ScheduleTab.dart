import 'package:flutter/material.dart';
import 'package:lets_com/pages/Post_login/HI_pages/styles/colors.dart';
import '../styles/styles.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

enum FilterStatus { Pending, Upcoming, Completed }

List<Map> schedules = [
  {
    'img': 'assets/assistant01.jpeg',
    'assistantName': 'Ms. Selam Wagaye',
    'assistantLocation': 'Debre-Markos',
    'reservedDate': 'Monday, Aug 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Pending,
  },
  {
    'img': 'assets/person.png',
    'assistantName': 'Mr. Kebede Abebe',
    'assistantLocation': 'Bahirdar',
    'reservedDate': 'Monday, Sep 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Pending,
  },
  {
    'img': 'assets/assistant03.jpeg',
    'assistantName': 'Ms. Azeb Mesfen',
    'assistantLocation': 'Kebridehar',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Pending,
  },
  {
    'img': 'assets/assistant04.jpeg',
    'assistantName': 'Mr. Ayana Demamu',
    'assistantLocation': 'Benishangulgumuz',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming,
  },
  {
    'img': 'assets/assistant05.jpeg',
    'assistantName': 'Ms. Almaz Nadew',
    'assistantLocation': 'Hosaina',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Completed,
  },
  {
    'img': 'assets/assistant05.jpeg',
    'assistantName': 'Mr. Abebe Kebede',
    'assistantLocation': 'Sheno',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Completed,
  },
];

class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus status = FilterStatus.Pending;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == status;
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Schedule',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                status = filterStatus;
                                if (status == FilterStatus.Pending) {
                                  _alignment = Alignment.centerLeft;
                                } else if (status == FilterStatus.Upcoming) {
                                  _alignment = Alignment.center;
                                } else if (status == FilterStatus.Completed) {
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  var _schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length - 1 == index;
                  return Card(
                    margin: !isLastElement
                        ? EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(_schedule['img']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule['assistantName'],
                                    style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _schedule['assistantLocation'],
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DateTimeCard(),
                          SizedBox(
                            height: 15,
                          ),
                          if (status != FilterStatus.Completed &&
                              _schedule['status'] == FilterStatus.Upcoming)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: Text('Reschedule'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(MyColors.primary),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            )
                          else if (status != FilterStatus.Completed &&
                              _schedule['status'] != FilterStatus.Upcoming)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: Text('Reschedule'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(MyColors.primary),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    child: Text('Cancel'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(MyColors.primary),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reserved Date',
                style: TextStyle(
                  color: Color(MyColors.grey02),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Reserved Time',
                style: TextStyle(
                  color: Color(MyColors.grey02),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monday, Aug 29',
                style: TextStyle(
                  color: Color(MyColors.header01),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '11:00 - 12:00',
                style: TextStyle(
                  color: Color(MyColors.header01),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
