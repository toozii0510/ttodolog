# ttodolog

# 🧶 뜨도록 (Ttodolog)
**도안 제작 도구 웹 애플리케이션**

의류 시장 데이터를 적용해 개인 맞춤형 템플릿을 제공하는 뜨개 도안 제작 서비스

---

## 📜 Features
- 📐 **패턴 생성**: 사용자의 입력값을 바탕으로 차트 도안 생성
- 🔄 **사이즈 자동 변환**: 입력된 수치를 기반으로 패턴 조정
- 📂 **도안 저장 및 공유**
- 📊 **스와치 데이터 관리**: 실 및 스와치 정보를 저장하여 활용 가능
- 🌐 **반응형 디자인**: 모바일 및 태블릿에서도 사용 가능

---

## 🚀 Tech Stack
- **Backend**: Django, Django REST Framework
- **Frontend**: Flutter (Web 지원 예정)
- **Database**: MySQL (Docker 기반)
- **Deployment**: Docker, Nginx, Gunicorn

---

## 🔧 설치 및 실행 방법
### **1️⃣ 필수 조건**
- Python 3.10 이상
- Docker & Docker Compose
- Git

### **2️⃣ 프로젝트 실행**

- Django 실행 시
cd BE
source venv/bin/activate  # 가상환경 활성화
python manage.py runserver

- Flutter 실행 시
cd FE
flutter run
