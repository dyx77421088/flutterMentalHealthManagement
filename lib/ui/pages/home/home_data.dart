import 'package:flutter/material.dart';

class WDXHomeData {
  Widget image;
  String title, content;
  int count, fen;
  WDXHomeData({this.image, this.title, this.content, this.count, this.fen});
}

List<WDXHomeData> data = [
  WDXHomeData(
    image: Image.asset("assets/images/1.jpg"),
    title: "SDS抑郁自评量表",
    content: "国际通用的抑郁自评量表，可以快速了解自身的抑郁水平。",
    count: 5,
  ),
  WDXHomeData(
    image: Image.asset("assets/images/2.jpg"),
    title: "中学生心理测试",
    content: "中学生心理测试是对中学生健康的综合测量，适用于对中学生心理健康的整体测查。",
    count: 10,
  ),
  WDXHomeData(
    image: Image.asset("assets/images/3.jpg"),
    title: "儿童抑郁障碍自评量表",
    content: "了解儿童的抑郁程度，适用于中国儿童的抑郁量表。",
    count: 8,
  ),
  WDXHomeData(
    image: Image.asset("assets/images/4.jpg"),
    title: "综合心理健康评估",
    content: "国际通用的心理健康评估量表，用于评定个体在抑郁、焦虑、人际、睡眠等多个方面的健康状况，可以较准确地区分出有心理问题的人。",
    count: 12,
  ),
  WDXHomeData(
    image: Image.asset("assets/images/5.jpg"),
    title: "贝克抑郁自评量表",
    content: "内容简明、 操作简单，可以较准确地反映你主观感受到的抑郁程度。",
    count: 15,
  ),
  WDXHomeData(
    image: Image.asset("assets/images/6.jpg"),
    title: "瑞文智力测试",
    content: "国际通用的非文字智力IQ测验，用于测试一个人的观察能力和思维能力。",
    count: 16,
  ),
  WDXHomeData(
    image: Image.asset("assets/images/7.jpg"),
    title: "贝克焦虑量表",
    content: "内容简明、 操作简单，可以较准确地反映你主观感受到的焦虑程度。",
    count: 20,
  ),
  WDXHomeData(
    image: Image.asset("assets/images/8.jpg"),
    title: "SAS焦虑自评量表",
    content: "适度压力提高生活效率，过度压力影响正常生活，来测一测自己的心理压力水平吧！",
    count: 22,
  ),
  WDXHomeData(
    image: Image.asset("assets/images/9.jpg"),
    title: "MMPI多项人格测试",
    content: "从抑郁、妄想等10个维度反映个体的心理健康状态，也可以用于正常人的性格评定。",
    count: 18,
  ),
];