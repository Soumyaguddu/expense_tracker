import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

import 'blocs/internet_cubit/internet_cubit.dart';
import 'blocs/routes/Routes.dart';
class SmsFetchScreen extends StatefulWidget {
  const SmsFetchScreen({super.key});

  @override
  State<SmsFetchScreen> createState() => _SmsFetchScreenState();
}

class _SmsFetchScreenState extends State<SmsFetchScreen> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker Sms ',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bank SMS Inbox Example'),
        ),
        body: SafeArea(
          child: BlocConsumer<InternetCubit, InternetState>(
            builder: (BuildContext context, InternetState state) {
            if (state ==InternetState.Gain) {
              return  Container(
                padding: const EdgeInsets.all(10.0),
                child: _messages.isNotEmpty
                    ? _MessagesListView(messages: _messages)
                    : Center(
                  child: Text(
                    'No bank messages to show.\nTap refresh button...',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else if (state ==InternetState.Loss) {
              return const Text("Internet Not Connected...");
            } else {
              return const Text("Loading...");
            }
          },
            listener: (BuildContext context, InternetState state) {
              if (state ==InternetState.Gain) {
                _fetchBankMessages();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Internet Connected!"),
                    backgroundColor: Colors.green));
              }
              else if (state ==InternetState.Loss) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Internet Not Connected!"),
                    backgroundColor: Colors.red));
              }
            },),

          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.pushNamed(context, Routes.first_screen);
          },
        ),

      ),
    );
  }



  Future<void> _fetchBankMessages() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      // Fetch SMS messages after permission is granted
      await _getBankMessages();
    } else {
      // Request permission and then fetch SMS messages
      permission = await Permission.sms.request();
      if (permission.isGranted) {
        await _getBankMessages();
      } else {
        // Handle the case where the permission is denied
        print("SMS permission not granted");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("SMS permission not granted"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _getBankMessages() async {
    final messages = await _query.querySms(
      kinds: [SmsQueryKind.inbox],
      count: 100,
    );

    if (messages.isEmpty) {
      print("No messages found in inbox");
    } else {
      print("Fetched ${messages.length} messages");
    }

    List<SmsMessage> bankMessages = messages.where((message) {
      String body = message.body?.toLowerCase() ?? '';
      return body.contains('credited') || body.contains('debited');
    }).toList();
    List<Map<String, dynamic>> bankMessagesWithAmount = messages.where((message) {
      String body = message.body?.toLowerCase() ?? '';
      return body.contains('credited') || body.contains('debited');
    }).map((message) {
      // Extract the amount using a regular expression
      final RegExp amountRegExp = RegExp(r'INR\s*([\d,]+\.\d{2})');
      final match = amountRegExp.firstMatch(message.body ?? '');
      String? amount = match != null ? match.group(1) : null;

      // Create a map with the relevant information
      return {
        'amount': amount,
        'body': message.body,
        'date': message.date,
        'sender': message.sender,
      };
    }).toList();
    print("bankMessagesWithAmount===$bankMessagesWithAmount");
    if (bankMessages.isEmpty) {
      print("No bank-related messages found");
    }

    setState(() => _messages = bankMessages);
  }



}
class _MessagesListView extends StatelessWidget {
  const _MessagesListView({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int i) {
        var message = messages[i];
        print("message===${message.body}====${message.kind}====${message.date}====${message.address}====${message.id}");

        return Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${message.sender} [${message.date}]'),
                const SizedBox(height: 12),
                Text('${message.body}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
