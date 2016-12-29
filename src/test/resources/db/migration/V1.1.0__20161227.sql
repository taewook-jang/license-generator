######################################################################
##
## dream-ant axboot Flyway 스크립트
##
######################################################################

## [초기 데이터 생성]
## 01. auth_group_map
## 02. child_sample
## 03. common_code
## 04. error_log
## 05. file
## 06. menu
## 07. parent_sample
## 08. program
## 09. user
## 10. user_auth
## 11. user_role

# ___ auth_group_map ___
INSERT INTO `auth_group_map` (`GRP_AUTH_CD`, `MENU_ID`, `CREATED_AT`, `CREATED_BY`, `UPDATED_AT`, `UPDATED_BY`, `DEL_AH`, `EXL_AH`, `FN1_AH`, `FN2_AH`, `FN3_AH`, `FN4_AH`, `FN5_AH`, `SAV_AH`, `SCH_AH`) VALUES
	('S0001', 1, '2016-12-21 14:17:59', 'system', '2016-12-21 14:17:59', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'Y'),
	('S0001', 2, '2016-12-21 14:57:38', 'system', '2016-12-21 14:57:38', 'test', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'Y'),
	('S0001', 3, '2016-12-21 14:17:59', 'system', '2016-12-21 14:17:59', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'Y'),
	('S0001', 4, '2016-12-21 14:54:55', 'system', '2016-12-21 14:54:55', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'Y'),
	('S0001', 5, '2016-12-21 14:18:00', 'system', '2016-12-21 14:18:00', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'Y'),
	('S0001', 6, '2016-12-21 14:18:00', 'system', '2016-12-21 14:18:00', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y'),
	('S0001', 7, '2016-12-21 14:18:00', 'system', '2016-12-21 14:18:00', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y'),
	('S0001', 8, '2016-12-21 14:18:01', 'system', '2016-12-21 14:18:01', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0001', 9, '2016-12-21 14:18:01', 'system', '2016-12-21 14:18:01', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0001', 10, '2016-12-21 14:18:01', 'system', '2016-12-21 14:18:01', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0001', 11, '2016-12-21 16:19:01', 'system', '2016-12-21 16:19:01', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0001', 12, '2016-12-21 14:18:01', 'system', '2016-12-21 14:18:01', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'Y'),
	('S0001', 13, '2016-12-21 14:18:02', 'system', '2016-12-21 14:18:02', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'Y'),
	('S0001', 14, '2016-12-21 14:18:02', 'system', '2016-12-21 14:18:02', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y', 'Y'),
	('S0001', 15, '2016-12-21 14:18:02', 'system', '2016-12-21 14:18:02', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0001', 16, '2016-12-21 15:26:06', 'system', '2016-12-21 15:26:06', 'test', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0001', 19, '2016-12-21 16:40:21', 'system', '2016-12-21 16:40:21', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y'),
	('S0001', 25, '2016-12-21 16:46:05', 'system', '2016-12-21 16:46:05', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0001', 26, '2016-12-21 17:03:02', 'system', '2016-12-21 17:03:02', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0001', 27, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0002', 4, '2016-12-21 14:54:55', 'system', '2016-12-21 14:54:55', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0002', 16, '2016-12-21 15:26:06', 'test', '2016-12-21 15:26:06', 'test', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y'),
	('S0002', 18, '2016-12-21 16:07:12', 'system', '2016-12-21 16:07:12', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y'),
	('S0002', 19, '2016-12-21 16:40:21', 'system', '2016-12-21 16:40:21', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'Y'),
	('S0002', 21, '2016-12-21 16:24:09', 'system', '2016-12-21 16:24:09', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0002', 22, '2016-12-21 16:21:48', 'system', '2016-12-21 16:21:48', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'),
	('S0002', 25, '2016-12-21 16:46:05', 'system', '2016-12-21 16:46:05', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N');

# ___ common_code ___
INSERT INTO `common_code` (`CODE`, `GROUP_CD`, `CREATED_AT`, `CREATED_BY`, `UPDATED_AT`, `UPDATED_BY`, `DATA1`, `DATA2`, `DATA3`, `DATA4`, `DATA5`, `GROUP_NM`, `NAME`, `REMARK`, `SORT`, `USE_YN`) VALUES
	('ACCOUNT_LOCK', 'USER_STATUS', '2016-12-21 14:17:55', 'system', '2016-12-21 14:17:55', 'system', NULL, NULL, NULL, NULL, NULL, '계정상태', '잠김', NULL, 2, 'Y'),
	('API', 'USER_ROLE', '2016-12-21 14:17:56', 'system', '2016-12-21 14:17:56', 'system', NULL, NULL, NULL, NULL, NULL, '사용자 롤', 'API 접근 롤', NULL, 6, 'Y'),
	('ASP_ACCESS', 'USER_ROLE', '2016-12-21 14:17:56', 'system', '2016-12-21 14:17:56', 'system', NULL, NULL, NULL, NULL, NULL, '사용자 롤', '관리시스템 접근 롤', NULL, 1, 'Y'),
	('ASP_MANAGER', 'USER_ROLE', '2016-12-21 14:17:56', 'system', '2016-12-21 14:17:56', 'system', NULL, NULL, NULL, NULL, NULL, '사용자 롤', '일반괸리자 롤', NULL, 3, 'Y'),
	('en_US', 'LOCALE', '2016-12-21 14:17:56', 'system', '2016-12-21 14:17:56', 'system', NULL, NULL, NULL, NULL, NULL, '로케일', '미국', NULL, 2, 'Y'),
	('ko_KR', 'LOCALE', '2016-12-21 14:17:57', 'system', '2016-12-21 14:17:57', 'system', NULL, NULL, NULL, NULL, NULL, '로케일', '대한민국', NULL, 1, 'Y'),
	('N', 'DEL_YN', '2016-12-21 14:17:57', 'system', '2016-12-21 14:17:57', 'system', NULL, NULL, NULL, NULL, NULL, '삭제여부', '미삭제', NULL, 1, 'Y'),
	('N', 'USE_YN', '2016-12-21 14:17:57', 'system', '2016-12-21 14:17:57', 'system', NULL, NULL, NULL, NULL, NULL, '사용여부', '사용안함', NULL, 2, 'Y'),
	('NORMAL', 'USER_STATUS', '2016-12-21 14:17:57', 'system', '2016-12-21 14:17:57', 'system', NULL, NULL, NULL, NULL, NULL, '계정상태', '활성', NULL, 1, 'Y'),
	('S0001', 'AUTH_GROUP', '2016-12-21 14:17:57', 'system', '2016-12-21 14:17:57', 'system', NULL, NULL, NULL, NULL, NULL, '권한그룹', '시스템관리자 그룹', NULL, 1, 'Y'),
	('S0002', 'AUTH_GROUP', '2016-12-21 14:17:58', 'system', '2016-12-21 14:17:58', 'system', NULL, NULL, NULL, NULL, NULL, '권한그룹', '사용자 권한그룹', NULL, 2, 'Y'),
	('SYSTEM_MANAGER', 'MENU_GROUP', '2016-12-21 14:17:58', 'system', '2016-12-21 14:17:58', 'system', NULL, NULL, NULL, NULL, NULL, '메뉴그룹', '시스템 관리자 그룹', NULL, 1, 'Y'),
	('SYSTEM_MANAGER', 'USER_ROLE', '2016-12-21 14:17:58', 'system', '2016-12-21 14:17:58', 'system', NULL, NULL, NULL, NULL, NULL, '사용자 롤', '시스템 관리자 롤', NULL, 2, 'Y'),
	('TEST', 'TEST_CODE', '2016-12-21 16:18:19', 'system', '2016-12-21 16:18:19', 'system', NULL, NULL, NULL, NULL, NULL, '테스트', 'xptmxm', NULL, 1, 'Y'),
	('USER', 'MENU_GROUP', '2016-12-21 14:17:58', 'system', '2016-12-21 14:17:58', 'system', NULL, NULL, NULL, NULL, NULL, '메뉴그룹', '사용자 그룹', NULL, 2, 'Y'),
	('Y', 'DEL_YN', '2016-12-21 14:17:58', 'system', '2016-12-21 14:17:58', 'system', NULL, NULL, NULL, NULL, NULL, '삭제여부', '삭제', NULL, 2, 'Y'),
	('Y', 'USE_YN', '2016-12-21 14:17:59', 'system', '2016-12-21 14:17:59', 'system', NULL, NULL, NULL, NULL, NULL, '사용여부', '사용', NULL, 1, 'Y');

# ___ menu ___
INSERT INTO `menu` (`MENU_ID`, `CREATED_AT`, `CREATED_BY`, `UPDATED_AT`, `UPDATED_BY`, `LEVEL`, `MENU_GRP_CD`, `MENU_NM`, `PARENT_ID`, `PROG_CD`, `SORT`) VALUES
	(1, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 0, 'SYSTEM_MANAGER', '시스템관리', NULL, NULL, 0),
	(2, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '공통코드 관리', 1, 'system-config-common-code', 0),
	(3, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '프로그램 관리', 1, 'system-config-program', 1),
	(4, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '메뉴관리', 1, 'system-config-menu', 2),
	(5, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '사용자 관리', 1, 'system-auth-user', 3),
	(6, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '에러로그 조회', 1, 'system-operation-log', 4),
	(7, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 0, 'SYSTEM_MANAGER', '레이아웃 샘플', NULL, NULL, 1),
	(8, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '기본템플릿', 7, 'basic', 0),
	(9, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '좌우레이아웃', 7, 'vertical-layout', 1),
	(10, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '상하레이아웃', 7, 'horizontal-layout', 2),
	(11, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '탭레이아웃', 7, 'tab-layout', 3),
	(12, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '그리드&폼 템플릿', 7, 'grid-form', 4),
	(13, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '그리드&탭폼 템플릿', 7, 'grid-tabform', 5),
	(14, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '그리드&모달 템플릿', 7, 'grid-modal', 6),
	(15, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', 'AX5UI샘플', 7, 'ax5ui-sample', 7),
	(19, '2016-12-21 16:40:21', 'system', '2016-12-21 16:40:21', 'system', 0, 'USER', 'menu1', NULL, 'ax5ui-sample', 0),
	(20, '2016-12-21 16:40:21', 'system', '2016-12-21 16:40:21', 'system', 0, 'USER', '새 메뉴', NULL, NULL, 1),
	(21, '2016-12-21 16:40:21', 'system', '2016-12-21 16:40:21', 'system', 1, 'USER', '새 메뉴', 20, 'horizontal-layout', 0),
	(22, '2016-12-21 16:40:21', 'system', '2016-12-21 16:40:21', 'system', 0, 'USER', 'test', NULL, 'basic', 2),
	(23, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 0, 'SYSTEM_MANAGER', '새 메뉴', NULL, NULL, 2),
	(24, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 0, 'SYSTEM_MANAGER', 'common', NULL, NULL, 3),
	(25, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '파일 브라우저', 24, 'fileBrowser', 0),
	(26, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', 'not_authorized', 24, 'not-authorized', 1),
	(27, '2016-12-21 17:05:08', 'system', '2016-12-21 17:05:08', 'system', 1, 'SYSTEM_MANAGER', '우편번호', 24, 'zipcode', 2);

# ___ parent_sample ___
INSERT INTO `parent_sample` (`SAMPLE_KEY`, `ETC1`, `ETC2`, `ETC3`, `ETC4`, `SAMPLE_VALUE`) VALUES
	('1', NULL, 'ko_KR', 'Y', NULL, NULL),
	('12', NULL, 'ko_KR', 'Y', NULL, NULL),
	('121132122241241', NULL, 'ko_KR', 'Y', NULL, NULL),
	('12113212241241', NULL, 'ko_KR', 'Y', NULL, NULL),
	('121132224124', NULL, 'ko_KR', 'Y', NULL, NULL),
	('1211322241241', NULL, 'ko_KR', 'Y', NULL, NULL),
	('12113224124', NULL, 'ko_KR', 'Y', NULL, NULL),
	('12132', NULL, 'ko_KR', 'Y', NULL, NULL),
	('12132124', NULL, 'ko_KR', 'Y', NULL, NULL),
	('1213224124', NULL, 'ko_KR', 'Y', NULL, NULL),
	('121324124', NULL, 'ko_KR', 'Y', NULL, NULL);

# ___ program ___
INSERT INTO `program` (`PROG_CD`, `CREATED_AT`, `CREATED_BY`, `UPDATED_AT`, `UPDATED_BY`, `AUTH_CHECK`, `DEL_AH`, `EXL_AH`, `FN1_AH`, `FN2_AH`, `FN3_AH`, `FN4_AH`, `FN5_AH`, `PROG_NM`, `PROG_PH`, `REMARK`, `SAV_AH`, `SCH_AH`, `TARGET`) VALUES
	('api', '2016-12-21 14:17:47', 'system', '2016-12-21 14:17:47', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'API', '/swagger/', NULL, 'Y', 'Y', '_self'),
	('ax5ui-sample', '2016-12-21 14:17:47', 'system', '2016-12-21 14:17:47', 'system', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[샘플]AX5UI', '/jsp/_samples/ax5ui-sample.jsp', NULL, 'Y', 'Y', '_self'),
	('axboot-js', '2016-12-21 14:17:47', 'system', '2016-12-21 14:17:47', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[API]axboot.js', '/jsp/_apis/axboot-js.jsp', NULL, 'N', 'N', '_self'),
	('basic', '2016-12-21 17:37:15', 'system', '2016-12-21 17:37:15', 'system', 'N', 'Y', 'Y', 'N', 'N', 'N', 'N', 'N', '테스트', '/jsp/_samples/basic.jsp', NULL, 'Y', 'Y', '_self'),
	('fileBrowser', '2016-12-21 16:45:48', 'system', '2016-12-21 16:45:48', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[공통] 파일브라우저', '/jsp/common/fileBrowser.jsp', NULL, 'N', 'N', '_self'),
	('grid-form', '2016-12-21 14:17:48', 'system', '2016-12-21 14:17:48', 'system', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[샘플]그리드&폼 템플릿', '/jsp/_samples/grid-form.jsp', NULL, 'Y', 'Y', '_self'),
	('grid-modal', '2016-12-21 14:17:48', 'system', '2016-12-21 14:17:48', 'system', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[샘플]모달 템플릿', '/jsp/_samples/grid-modal.jsp', NULL, 'Y', 'Y', '_self'),
	('grid-tabform', '2016-12-21 14:17:48', 'system', '2016-12-21 14:17:48', 'system', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[샘플]그리드&탭폼 템플릿', '/jsp/_samples/grid-tabform.jsp', NULL, 'Y', 'Y', '_self'),
	('horizontal-layout', '2016-12-21 14:17:48', 'system', '2016-12-21 14:17:48', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[샘플]상하레이아웃', '/jsp/_samples/horizontal-layout.jsp', NULL, 'N', 'N', '_self'),
	('login', '2016-12-21 14:17:48', 'system', '2016-12-21 14:17:48', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '로그인', '/jsp/login.jsp', NULL, 'N', 'N', '_self'),
	('main', '2016-12-21 14:17:49', 'system', '2016-12-21 14:17:49', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '메인', '/jsp/main.jsp', NULL, 'N', 'N', '_self'),
	('not-authorized', '2016-12-21 17:02:09', 'system', '2016-12-21 17:02:09', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[공통] not_authorized', '/jsp/common/not-authorized.jsp', NULL, 'N', 'N', '_self'),
	('page-structure', '2016-12-21 14:17:49', 'system', '2016-12-21 14:17:49', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[샘플]페이지구조', '/jsp/_samples/page-structure.jsp', NULL, 'N', 'N', '_self'),
	('system-auth-user', '2016-12-21 14:17:49', 'system', '2016-12-21 14:17:49', 'system', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '사용자관리', '/jsp/system/system-auth-user.jsp', NULL, 'Y', 'Y', '_self'),
	('system-config-common-code', '2016-12-21 14:17:49', 'system', '2016-12-21 14:17:49', 'system', 'Y', 'N', 'Y', 'N', 'N', 'N', 'N', 'N', '공통코드관리', '/jsp/system/system-config-common-code.jsp', NULL, 'Y', 'Y', '_self'),
	('system-config-menu', '2016-12-21 14:56:44', 'system', '2016-12-21 14:56:44', 'test', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '메뉴관리', '/jsp/system/system-config-menu.jsp', '메뉴 관리', 'Y', 'Y', '_self'),
	('system-config-program', '2016-12-21 14:17:50', 'system', '2016-12-21 14:17:50', 'system', 'Y', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '프로그램관리', '/jsp/system/system-config-program.jsp', NULL, 'Y', 'Y', '_self'),
	('system-help-manual', '2016-12-21 14:17:50', 'system', '2016-12-21 14:17:50', 'system', 'Y', 'N', 'N', 'Y', 'N', 'N', 'N', 'N', '매뉴얼 관리', '/jsp/system/system-help-manual.jsp', NULL, 'Y', 'Y', '_self'),
	('system-operation-log', '2016-12-21 14:17:50', 'system', '2016-12-21 14:17:50', 'system', 'Y', 'N', 'N', 'Y', 'N', 'N', 'N', 'N', '에러로그 조회', '/jsp/system/system-operation-log.jsp', NULL, 'N', 'Y', '_self'),
	('tab-layout', '2016-12-21 14:17:50', 'system', '2016-12-21 14:17:50', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[샘플]탭레이아웃', '/jsp/_samples/tab-layout.jsp', NULL, 'N', 'N', '_self'),
	('vertical-layout', '2016-12-21 14:17:51', 'system', '2016-12-21 14:17:51', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[샘플]좌우레이아웃', '/jsp/_samples/vertical-layout.jsp', NULL, 'N', 'N', '_self'),
	('zipcode', '2016-12-21 17:04:12', 'system', '2016-12-21 17:04:12', 'system', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', '[공통] 우편번호', '/jsp/common/zipcode.jsp', NULL, 'N', 'N', '_self');

# ___ user ___
INSERT INTO `user` (`USER_CD`, `CREATED_AT`, `CREATED_BY`, `UPDATED_AT`, `UPDATED_BY`, `DEL_YN`, `EMAIL`, `HP_NO`, `IP`, `LAST_LOGIN_DATE`, `LOCALE`, `MENU_GRP_CD`, `PASSWORD_UPDATE_DATE`, `REMARK`, `USE_YN`, `USER_NM`, `USER_PS`, `USER_STATUS`) VALUES
	('system', '2016-12-21 14:17:42', 'system', '2016-12-21 14:17:42', 'system', 'N', NULL, NULL, NULL, '0000-00-00 00:00:00', 'ko_KR', 'SYSTEM_MANAGER', '0000-00-00 00:00:00', NULL, 'Y', '시스템 관리자', '$2a$11$ruVkoieCPghNOA6mtKzWReZ5Ee66hbeqwvlBT1z.W4VMYckBld6uC', 'NORMAL'),
	('test', '2016-12-21 15:24:26', 'system', '2016-12-21 15:24:26', 'test', 'N', NULL, NULL, NULL, '0000-00-00 00:00:00', 'ko_KR', 'USER', '2016-12-21 14:20:28', NULL, 'Y', '홍길동', '$2a$11$XXPPIheqn5tXvgrqHe6XUexim9p46cIfCPtLVrn5HOxwajNvsEjb2', 'NORMAL');

# ___ user_auth ___
INSERT INTO `user_auth` (`ID`, `CREATED_AT`, `CREATED_BY`, `UPDATED_AT`, `UPDATED_BY`, `GRP_AUTH_CD`, `USER_CD`) VALUES
	(1, '2016-12-21 14:17:46', 'system', '2016-12-21 14:17:46', 'system', 'S0001', 'system'),
	(11, '2016-12-21 16:39:32', 'system', '2016-12-21 16:39:32', 'system', 'S0002', 'test');

# ___ user_role ___
INSERT INTO `user_role` (`ID`, `CREATED_AT`, `CREATED_BY`, `UPDATED_AT`, `UPDATED_BY`, `ROLE_CD`, `USER_CD`) VALUES
	(3, '2016-12-21 14:17:45', 'system', '2016-12-21 14:17:45', 'system', 'ASP_ACCESS', 'system'),
	(4, '2016-12-21 14:17:45', 'system', '2016-12-21 14:17:45', 'system', 'SYSTEM_MANAGER', 'system'),
	(16, '2016-12-21 16:39:32', 'system', '2016-12-21 16:39:32', 'system', 'ASP_ACCESS', 'test');
