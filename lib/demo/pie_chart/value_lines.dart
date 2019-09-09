import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mp_flutter_chart/chart/mp/chart/pie_chart.dart';
import 'package:mp_flutter_chart/chart/mp/core/animator.dart';
import 'package:mp_flutter_chart/chart/mp/core/data/pie_data.dart';
import 'package:mp_flutter_chart/chart/mp/core/data_set/pie_data_set.dart';
import 'package:mp_flutter_chart/chart/mp/core/description.dart';
import 'package:mp_flutter_chart/chart/mp/core/entry/entry.dart';
import 'package:mp_flutter_chart/chart/mp/core/entry/pie_entry.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_horizontal_alignment.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_orientation.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/legend_vertical_alignment.dart';
import 'package:mp_flutter_chart/chart/mp/core/enums/value_position.dart';
import 'package:mp_flutter_chart/chart/mp/core/highlight/highlight.dart';
import 'package:mp_flutter_chart/chart/mp/core/poolable/point.dart';
import 'package:mp_flutter_chart/chart/mp/core/utils/color_utils.dart';
import 'package:mp_flutter_chart/chart/mp/core/utils/utils.dart';
import 'package:mp_flutter_chart/chart/mp/core/value_formatter/percent_formatter.dart';
import 'package:mp_flutter_chart/chart/mp/listener.dart';

class PieChartValueLines extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PieChartValueLinesState();
  }
}

class PieChartValueLinesState extends State<PieChartValueLines>
    implements OnChartValueSelectedListener {
  PieChart _pieChart;
  PieData _pieData;

  var random = Random(1);

  int _count = 4;
  double _range = 100.0;

  @override
  void initState() {
    _initPieData(_count, _range);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initPieChart();
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Pie Chart Value Lines")),
        body: Stack(
          children: <Widget>[
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 100,
              child: _pieChart,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                            child: Slider(
                                value: _count.toDouble(),
                                min: 0,
                                max: 25,
                                onChanged: (value) {
                                  _count = value.toInt();
                                  _initPieData(_count, _range);
                                  setState(() {});
                                })),
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Text(
                            "$_count",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorUtils.BLACK,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                            child: Slider(
                                value: _range,
                                min: 0,
                                max: 200,
                                onChanged: (value) {
                                  _range = value;
                                  _initPieData(_count, _range);
                                  setState(() {});
                                })),
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Text(
                            "${_range.toInt()}",
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorUtils.BLACK,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  final List<String> PARTIES = List()
    ..add("Party A")
    ..add("Party B")
    ..add("Party C")
    ..add("Party D")
    ..add("Party E")
    ..add("Party F")
    ..add("Party G")
    ..add("Party H")
    ..add("Party I")
    ..add("Party J")
    ..add("Party K")
    ..add("Party L")
    ..add("Party M")
    ..add("Party N")
    ..add("Party O")
    ..add("Party P")
    ..add("Party Q")
    ..add("Party R")
    ..add("Party S")
    ..add("Party T")
    ..add("Party U")
    ..add("Party V")
    ..add("Party W")
    ..add("Party X")
    ..add("Party Y")
    ..add("Party Z");

  PercentFormatter _formatter = PercentFormatter();

  void _initPieData(int count, double range) {
    List<PieEntry> entries = List();

    // NOTE: The order of the entries when being added to the entries array determines their position around the center of
    // the chart.
    for (int i = 0; i < count; i++) {
      entries.add(PieEntry(
          value: (random.nextDouble() * range) + range / 5,
          label: PARTIES[i % PARTIES.length]));
    }

    PieDataSet dataSet = new PieDataSet(entries, "Election Results");
    dataSet.setSliceSpace(3);
    dataSet.setSelectionShift(5);

    // add a lot of colors

    List<Color> colors = List();

    for (Color c in ColorUtils.VORDIPLOM_COLORS) colors.add(c);

    for (Color c in ColorUtils.JOYFUL_COLORS) colors.add(c);

    for (Color c in ColorUtils.COLORFUL_COLORS) colors.add(c);

    for (Color c in ColorUtils.LIBERTY_COLORS) colors.add(c);

    for (Color c in ColorUtils.PASTEL_COLORS) colors.add(c);

    colors.add(ColorUtils.HOLO_BLUE);

    dataSet.setColors1(colors);
    //dataSet.setSelectionShift(0f);

    dataSet.setValueLinePart1OffsetPercentage(80.0);
    dataSet.setValueLinePart1Length(0.2);
    dataSet.setValueLinePart2Length(0.4);
    //dataSet.setUsingSliceColorAsValueLineColor(true);

    //dataSet.setXValuePosition(PieDataSet.ValuePosition.OUTSIDE_SLICE);
    dataSet.setYValuePosition(ValuePosition.OUTSIDE_SLICE);

    _pieData = PieData(dataSet)
      ..setValueFormatter(_formatter)
      ..setValueTextSize(11)
      ..setValueTextColor(ColorUtils.BLACK);
//    ..setValueTypeface(tf);
  }

  void _initPieChart() {
    var desc = Description();
    desc.setEnabled(false);
    _pieChart = PieChart(_pieData, (painter) {
      _formatter.setPieChartPainter(painter);

      painter
        ..setUsePercentValues(true)
        ..mExtraLeftOffset = 20
        ..mExtraTopOffset = 0
        ..mExtraRightOffset = 20
        ..mExtraBottomOffset = 0
        ..mDragDecelerationFrictionCoef = 0.95
//      ..setCenterTextTypeface()
        ..setCenterText("value lines")
        ..setDrawHoleEnabled(true)
        ..setHoleColor(ColorUtils.WHITE)
        ..setTransparentCircleColor(ColorUtils.WHITE)
        ..setTransparentCircleAlpha(110)
        ..setHoleRadius(58)
        ..setTransparentCircleRadius(61)
        ..setDrawCenterText(true)
        ..setRotationEnabled(true)
        ..mHighLightPerTapEnabled = true
        ..highlightValues(null)
        ..setOnChartValueSelectedListener(this);

      painter.mLegend
        ..setVerticalAlignment(LegendVerticalAlignment.TOP)
        ..setHorizontalAlignment(LegendHorizontalAlignment.RIGHT)
        ..setOrientation(LegendOrientation.VERTICAL)
        ..setDrawInside(false)
        ..setEnabled(false);

      painter.mAnimator.animateY2(1400, Easing.EaseInOutQuad);
    },
        rotateEnabled: true,
        drawHole: true,
        extraLeftOffset: 5,
        extraTopOffset: 10,
        extraRightOffset: 5,
        extraBottomOffset: 5,
        usePercentValues: true,
        touchEnabled: true,
        dragDecelerationFrictionCoef: 0.95,
        desc: desc);
  }

  @override
  void onNothingSelected() {}

  @override
  void onValueSelected(Entry e, Highlight h) {}
}