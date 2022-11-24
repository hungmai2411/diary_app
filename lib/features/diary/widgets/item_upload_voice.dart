import 'dart:async';

import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:record/record.dart';

class ItemUploadVoice extends StatefulWidget {
  const ItemUploadVoice({super.key});

  @override
  State<ItemUploadVoice> createState() => _ItemUploadVoiceState();
}

class _ItemUploadVoiceState extends State<ItemUploadVoice> {
  // dùng để ghi âm
  final record = Record();
  // dùng để check trạng thái ghi âm
  bool isRecording = false;
  bool isPause = false;
  double time = 0;

  late Timer _timer;

  recordVoice() async {
    if (isRecording) {
      record.stop();
      _timer.cancel();
      setState(() {
        isRecording = false;
      });
    } else if (isPause) {
      setState(() {
        isRecording = true;
      });
      countTime();
    } else {
      if (await record.hasPermission()) {
        // Start recording
        await record.start(
          path: 'aFullPath/myFile.m4a',
          encoder: AudioEncoder.aacLc, // by default
          bitRate: 128000, // by default
        );
      }

      bool _isRecording = await record.isRecording();

      if (_isRecording) {
        countTime();
      } else {}

      setState(() {
        isRecording = _isRecording;
        isPause = true;
      });
    }
  }

  countTime() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        ++time;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your voice',
          style: AppStyles.medium.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 50),
        Center(
          child: Text(
            isRecording
                ? 'Tap to pause'
                : isPause
                    ? 'Tap to continue recording'
                    : 'Tap to record',
            style: AppStyles.medium.copyWith(fontSize: 18),
          ),
        ),
        const SizedBox(height: 5),
        if (isPause)
          Center(
            child: Text(
              "${(time ~/ 60).toInt().toString().padLeft(2, '0')}:${(time % 60).toInt().toString().padLeft(2, '0')}",
              style: AppStyles.medium.copyWith(
                fontSize: 18,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        Center(
          child: GestureDetector(
            onTap: recordVoice,
            child: Container(
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 30,
              ),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Center(
                child: Icon(
                  isRecording
                      ? FontAwesomeIcons.pause
                      : FontAwesomeIcons.microphone,
                  color: AppColors.primaryColor,
                  size: 40,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
