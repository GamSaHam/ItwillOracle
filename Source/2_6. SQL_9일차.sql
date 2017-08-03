
-- 백업 만들기
-- exp scott/tiger file=c:/test/emp.dmp log=c:/test/emp.log tables=scott.emp

    -- emp 테이블
    -- sucessfully로 명령어가 나오고 해당 경로에 dmp 파일과 log 파일이 저장 된다.


-- 복구하기
-- imp scott/tiger file=c:/test/emp.dmp log=c:/test/emp.log ignore=y
-- sucessfully로 확인할 수 있다.


-- Oracle SQL Developer 실행후
-- 테이블뷰에서 테이블 우클릭 익스포트한다.
-- 파일이 만들어지고 실행할려면 Oracle SQL Developer hgs 뷰에서 실행한다.
-- @c:\test\emp.sql


-- 자바에서 배포 할 시에 프로젝트 우클릭 Export 후 ArchiveFile을 한다.
-- 오라클이랑
-- jar 파일로 소스파일
