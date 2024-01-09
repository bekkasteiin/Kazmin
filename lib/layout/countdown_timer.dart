import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    Key key,
    int secondsRemaining,
    this.countDownTimerStyle,
    this.whenTimeExpires,
    this.countDownFormatter,
  })  : secondsRemaining = secondsRemaining,
        super(key: key);

  final int secondsRemaining;
  final Function whenTimeExpires;
  final Function countDownFormatter;
  final TextStyle countDownTimerStyle;

  @override
  State createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Duration duration;

  int get timerDurationString {
    final Duration duration = _controller.duration * _controller.value;
    return duration.inSeconds;
  }

  @override
  void initState() {
    super.initState();
    duration = Duration(seconds: widget.secondsRemaining);
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    _controller.reverse(from: widget.secondsRemaining.toDouble());
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.whenTimeExpires();
      }
    });
  }

  @override
  void didUpdateWidget(CountDownTimer oldWidget) {
    if (widget.secondsRemaining != oldWidget.secondsRemaining) {
      setState(() {
        duration = Duration(seconds: widget.secondsRemaining);
        _controller.dispose();
        _controller = AnimationController(
          vsync: this,
          duration: duration,
        );
        _controller.reverse(from: widget.secondsRemaining.toDouble());
        _controller.addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            widget.whenTimeExpires();
          } else if (status == AnimationStatus.dismissed) {
            print('Animation Complete');
          }
        });
      });
    }
  }

  String formatMM(int seconds) {
    final int minutes = (seconds / 60).truncate();
    final String minutesStr = (minutes).toString().padLeft(2, '0');
    return minutesStr;
  }

  String formatSS(int seconds) {
    seconds = (seconds % 3600).truncate();
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return secondsStr;
  }

  @override
  void dispose() {
    _controller.dispose();
    print('Timer Disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, Widget child) {
              return Row(
                children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${formatMM(timerDurationString)}:${formatSS(timerDurationString)}',
                          style: widget.countDownTimerStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },),);
  }
}
