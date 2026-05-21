# 1. 가벼운 Python 런타임 이미지 사용
FROM python:3.9-slim

# 2. 컨테이너 내부 작업 디렉토리 설정
WORKDIR /app

# 3. 의존성 파일만 먼저 복사 (캐싱 최적화)
# requirements.txt가 변경되지 않으면 pip install 단계를 건너뛰어 빌드 속도가 매우 빨라집니다.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. 애플리케이션 소스 코드 복사
COPY . .

# 5. 실행 권한 설정을 위한 사용자 생성 (보안 권장 사항)
RUN useradd -m myuser
USER myuser

# 6. 애플리케이션이 사용할 포트 설정
EXPOSE 80

# 7. 애플리케이션 실행 명령어
CMD ["python", "app.py"]