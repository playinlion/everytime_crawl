# README

## everytime 크롤러 v.1.0
*미완성, 돌려보는건 비추*

everytime 유저 아이디와 패스워드를 입력하면 해당 유저의 학교 시간표를 쇽쇽

#### 사용법
1. https://sites.google.com/a/chromium.org/chromedriver/downloads 크롬 드라이버 다운로드
2. 크롬 드라이버 경로 설정
3. 로그인
4. 유저 정보에 등록된 학교의 에브리타임 시간표 추출

***
### 개선이 필요한 사항

1. 에브리타임을 실행한 이후 팝업 알림이 뜬다. 이 창을 닫고 리스트에 접근해야 하는데 여기까지 소요되는 시간이 꽤나 길다.

2. ol[2], ol[3] 리스트를 순환하면서 클릭하는데, 대기 시간이 너무 짧으면 NoSuchElement, 너무 길면 낭비되는
   시간이 늘어난다.

3. 테이블을 읽어 내려가면서 DB에 데이터를 저장하는데, 테이블을 읽기 전에 해당 테이블 로딩이 끝나지 않으면 오류를 찾지
   못하고 이전 테이블의 데이터를 저장한다. 예를 들면 ol[3]/li[3]/table 데이터를 저장한 뒤 ol[3]/li[4]/table
   의 순서로 넘어갈 때, li[4]의 테이블이 로딩되지 않았으면 li[3]의 데이터를 한 번 더 저장한다는 소리.

4. 소스를 사용하려면 크롬 드라이버를 굳이 받아야함.

5. 중복되는 코드가 계속 나오는데 함수로 나눠서 코드 좀 보기 좋게 리팩토링 할 수 없을까?

6. 아 로그인도 지금 get 방식