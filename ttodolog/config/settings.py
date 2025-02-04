import os
import pymysql
pymysql.install_as_MySQLdb()

from pathlib import Path
from dotenv import load_dotenv

# .env 파일 로드
load_dotenv()

# BASE_DIR 설정
BASE_DIR = Path(__file__).resolve().parent.parent

# 보안 키
SECRET_KEY = os.getenv('SECRET_KEY', 'your-default-secret-key')

# 개발 환경에서는 DEBUG=True, 배포 환경에서는 False로 설정
DEBUG = os.getenv('DEBUG', 'True') == 'True'

# ALLOWED_HOSTS 설정
ALLOWED_HOSTS = os.getenv('ALLOWED_HOSTS', '*').split(',')

# Installed Apps
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',  # Django REST Framework 추가
]

# Middleware 설정
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',  
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',  
    'django.contrib.messages.middleware.MessageMiddleware',  
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

# URL 설정
ROOT_URLCONF = 'config.urls'

# Templates 설정
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

# WSGI 설정
WSGI_APPLICATION = 'config.wsgi.application'

# MySQL 데이터베이스 설정
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'ttodolog',
        'USER': 'toozii0510',
        'PASSWORD': '7848',
        'HOST': 'localhost',
        'PORT': '3306',
        'OPTIONS': {
            'charset': 'utf8mb4',
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'"
        },
    }
}

# 비밀번호 검증
AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

# 언어 & 시간대 설정
LANGUAGE_CODE = 'ko-kr'
TIME_ZONE = 'Asia/Seoul'
USE_I18N = True
USE_TZ = True

# 정적 파일 (CSS, JavaScript, 이미지)
STATIC_URL = 'static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'

# 기본 PK 필드 설정
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
