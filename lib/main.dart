import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MoodTrackerApp());

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MoodTrackerScreen(),
    );
  }
}

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  double? stressLevel;
  double? selfEsteem;
  String notes = '';
  String? selectedMood;
  Set<String> selectedEmotions = {};

  final List<String> moods = [
    'Радость',
    'Спокойствие',
    'Сила',
    'Страх',
    'Бешенство',
    'Грусть'
  ];
  final List<String> joyEmotions = [
    'Возбуждение',
    'Восторг',
    'Игривость',
    'Наслаждение',
    'Очарование',
    'Осознанность',
    'Смелость',
    'Удовольствие',
    'Чувственность',
    'Энергичность',
    'Экстравагантность'
  ];
  final List<String> fearEmotions = [
    'Тревога',
    'Беспокойство',
    'Паника',
  ];
  final List<String> calmEmotions = [
    'Гармония',
    'Расслабленность',
    'Умиротворение',
    'Уверенность',
    'Отсутствие тревоги',
  ];
  final List<String> strengthEmotions = [
    'Уверенность',
    'Внутренняя мощь',
    'Решительность',
  ];
  final List<String> rageEmotions = [
    'Ярость',
    'Агрессия',
    'Тремор',
  ];
  final List<String> sadnessEmotions = [
    'Тоска',
    'Меланхолия',
    'Чувство одиночества',
    'Разочарование',
    'Сожаление',
    'Потерянность',
  ];

  List<String> currentEmotions = [];

  int selectedTabIndex = 0;
  String currentDateTime = DateFormat('d MMMM HH:mm').format(DateTime.now());
  DateTime selectedDate = DateTime.now();

  Map<DateTime, Map<String, dynamic>> moodData = {};

  bool get isFormValid {
    return selectedMood != null &&
        stressLevel != null &&
        selfEsteem != null &&
        notes.isNotEmpty &&
        (selectedMood == 'Радость' ? selectedEmotions.isNotEmpty : true) &&
        (selectedMood == 'Страх' ? selectedEmotions.isNotEmpty : true);
  }

  void saveForm() {
    if (isFormValid) {
      setState(() {
        moodData[selectedDate] = {
          'mood': selectedMood,
          'stressLevel': stressLevel,
          'selfEsteem': selfEsteem,
          'notes': notes,
          'emotions': selectedEmotions.toList(),
        };
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Успешно!'),
            content: Text(
                'Ваше настроение сохранено за ${DateFormat('d MMMM').format(selectedDate)}.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            currentDateTime,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalendarScreen(
                          selectedDate: selectedDate,
                          onDateSelected: (DateTime date) {
                            setState(() {
                              selectedDate = date;
                              currentDateTime = DateFormat('d MMMM HH:mm')
                                  .format(selectedDate);
                            });
                            Navigator.pop(context);
                          },
                        )),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTabIndex = 0;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                      decoration: BoxDecoration(
                        color: selectedTabIndex == 0
                            ? Colors.orange
                            : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.book,
                            color: selectedTabIndex == 0
                                ? Colors.white
                                : Colors.grey.withOpacity(0.6),
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Дневник настроения',
                            style: TextStyle(
                              color: selectedTabIndex == 0
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTabIndex = 1;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                      decoration: BoxDecoration(
                        color: selectedTabIndex == 1
                            ? Colors.orange
                            : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: selectedTabIndex == 1
                                ? Colors.white
                                : Colors.grey.withOpacity(0.6),
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Статистика',
                            style: TextStyle(
                              color: selectedTabIndex == 1
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content for selected tab
          Expanded(
            child: IndexedStack(
              index: selectedTabIndex,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Что чувствуешь?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: moods.map((mood) {
                            final bool isSelected = selectedMood == mood;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedMood = mood;
                                  if (mood == 'Радость') {
                                    currentEmotions = joyEmotions;
                                  } else if (mood == 'Страх') {
                                    currentEmotions = fearEmotions;
                                  } else if (mood == 'Спокойствие') {
                                    currentEmotions = calmEmotions;
                                  } else if (mood == 'Сила') {
                                    currentEmotions = strengthEmotions;
                                  } else if (mood == 'Бешенство') {
                                    currentEmotions = rageEmotions;
                                  } else if (mood == 'Грусть') {
                                    currentEmotions = sadnessEmotions;
                                  } else {
                                    currentEmotions = [];
                                  }
                                  selectedEmotions.clear();
                                });
                              },
                              child: Container(
                                width: 83,
                                height: 118,
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(76),
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.orange
                                          : Colors.white,
                                      width: 2),
                                ),
                                child: Column(
                                  children: [
                                    if (mood == 'Радость') ...[
                                      Image.asset(
                                        'assets/hapiness.png',
                                        height: 50,
                                      ),
                                    ],
                                    if (mood == 'Спокойствие') ...[
                                      Image.asset(
                                        'assets/calm.png',
                                        height: 50,
                                      ),
                                    ],
                                    if (mood == 'Сила') ...[
                                      Image.asset(
                                        'assets/strength.png',
                                        height: 50,
                                      ),
                                    ],
                                    if (mood == 'Страх') ...[
                                      Image.asset(
                                        'assets/fear.png',
                                        height: 50,
                                      ),
                                    ],
                                    if (mood == 'Бешенство') ...[
                                      Image.asset(
                                        'assets/rage.png',
                                        height: 50,
                                      ),
                                    ],
                                    if (mood == 'Грусть') ...[
                                      Image.asset(
                                        'assets/sadness.png',
                                        height: 50,
                                      ),
                                    ],
                                    Text(
                                      mood,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: currentEmotions.map((emotion) {
                          final bool isSelected =
                              selectedEmotions.contains(emotion);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedEmotions.remove(emotion);
                                } else {
                                  selectedEmotions.add(emotion);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? Colors.orange : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                emotion,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Уровень стресса',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.orange,
                          inactiveTrackColor: Colors.grey[300],
                          thumbColor: Colors.orange,
                          overlayColor: Colors.orange.withOpacity(0.2),
                        ),
                        child: Slider(
                          value: stressLevel ?? 0.0,
                          min: 0,
                          max: 4,
                          divisions: 4,
                          onChanged: (value) {
                            setState(() {
                              stressLevel = value;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Низкий',
                              style: TextStyle(fontSize: 11,color: Colors.grey[400]),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Высокий',
                              style: TextStyle(fontSize: 11,color: Colors.grey[400]),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Самооценка',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.orange,
                          inactiveTrackColor: Colors.grey[300],
                          thumbColor: Colors.orange,
                          overlayColor: Colors.orange.withOpacity(0.2),
                        ),
                        child: Slider(
                          value: selfEsteem ?? 0.0,
                          min: 0,
                          max: 4,
                          divisions: 4,
                          onChanged: (value) {
                            setState(() {
                              selfEsteem = value;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Неуверенность',
                              style: TextStyle(fontSize: 11,color: Colors.grey[400]),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Уверенность',
                              style: TextStyle(fontSize: 11,color: Colors.grey[400]),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Заметки',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            notes = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Напишите свои мысли...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: isFormValid ? saveForm : null,
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 44),
                        backgroundColor: isFormValid ? Colors.orange : Colors.grey.shade400 ),
                        child: Text('Сохранить', style:TextStyle(
                          color:
                          isFormValid ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ), ),
                      ),
                    ],
                  ),
                ),
                Center(child: Text('Статистика еще не доступна')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarScreen extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarScreen(
      {super.key, required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите дату'),
      ),
      body: Center(
        child: CalendarDatePicker(
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2101),
          onDateChanged: (DateTime date) {
            onDateSelected(date);
          },
        ),
      ),
    );
  }
}
