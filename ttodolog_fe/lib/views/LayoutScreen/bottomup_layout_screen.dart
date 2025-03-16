import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttodolog_fe/%08viewmodels/measurement_viewmodel.dart';
import 'package:ttodolog_fe/models/template_model.dart';

/// ✅ 바텀업 도안 레이아웃 화면 (스크롤 가능하도록 수정)
class BottomUpLayoutScreen extends ConsumerStatefulWidget {
  const BottomUpLayoutScreen({super.key});

  @override
  ConsumerState<BottomUpLayoutScreen> createState() =>
      _BottomUpLayoutScreenState();
}

class _BottomUpLayoutScreenState extends ConsumerState<BottomUpLayoutScreen> {
  XFile? _selectedImage;
  final TextEditingController _projectNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final templateName = ref.watch(measurementViewModelProvider).knittingMethod;
    _projectNameController.text = templateName;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final measurementState = ref.watch(measurementViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("바텀업 도안 레이아웃"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          _buildPage("프로젝트 정보", _buildProjectInfo()),
          _buildPage("기본 치수", _buildMeasurementInfo(measurementState)),
          _buildPage("사용한 재료", _buildMaterialsInfo()),
          _buildPage("차트 편집", _buildChartEditSection(context)),
          _buildPage("저장 및 내보내기", _buildSaveButtons()),
        ],
      ),
    );
  }

  /// **📌 A4 크기의 페이지를 생성하는 함수**
  Widget _buildPage(String title, Widget child) {
    return Center(
      child: SingleChildScrollView(
        // ✅ 스크롤 가능하게 감싸기
        physics: const BouncingScrollPhysics(), // ✅ 스크롤 부드럽게
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              width: 793,
              height: 1122,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 3,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const Divider(),
                  const SizedBox(height: 10),
                  Expanded(child: child), // ✅ 컨텐츠가 많아도 크기 조정 가능
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// **📌 1. 프로젝트 정보 페이지**
  Widget _buildProjectInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField("프로젝트명", _projectNameController),
        const SizedBox(height: 20),
        _selectedImage != null
            ? Image.file(
                File(_selectedImage!.path),
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              )
            : const Text("이미지를 추가해주세요.",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text("이미지 업로드"),
        ),
      ],
    );
  }

  /// **📌 2. 기본 치수 정보 페이지**
  Widget _buildMeasurementInfo(TemplateModel measurementState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMeasurementText("가슴둘레", measurementState.chestWidth),
        _buildMeasurementText("총장",
            measurementState.sideLength + measurementState.bottomBandHeight),
        _buildMeasurementText("어깨너비", measurementState.shoulderWidth),
        _buildMeasurementText("진동길이", measurementState.armholeDepth),
        _buildMeasurementText("팔길이", measurementState.sleeveLength),
        _buildMeasurementText("소매너비", measurementState.sleeveWidth),
      ],
    );
  }

  Widget _buildMeasurementText(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text("$label: ${value.toStringAsFixed(1)} cm",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
    );
  }

  /// **📌 3. 사용한 실 및 재료 페이지**
  Widget _buildMaterialsInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField("사용한 실"),
        _buildInputField("바늘 호수"),
        _buildInputField("실 소요량"),
        _buildInputField("기타 부자재 및 도구"),
      ],
    );
  }

  /// **📌 4. 차트 편집 섹션 페이지**
  Widget _buildChartEditSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChartEditButton(context, "스와치 차트 편집"),
        _buildChartEditButton(context, "앞판 차트 편집"),
        _buildChartEditButton(context, "뒷판 차트 편집"),
        _buildChartEditButton(context, "소매 차트 편집"),
      ],
    );
  }

  Widget _buildChartEditButton(BuildContext context, String title) {
    return ElevatedButton.icon(
      onPressed: () {
        context.push("/chart_editor");
      },
      icon: const Icon(Icons.edit),
      label: Text(title),
    );
  }

  /// **📌 5. 저장 및 내보내기 페이지**
  Widget _buildSaveButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save),
            label: const Text("저장")),
        const SizedBox(height: 10),
        ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text("PDF 내보내기")),
      ],
    );
  }

  /// **📌 공통 입력 필드**
  Widget _buildInputField(String label, [TextEditingController? controller]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }
}
