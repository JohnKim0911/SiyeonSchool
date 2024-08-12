<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="resources/css/contacts.css">
	<script defer src="resources/js/contacts.js"></script>
</head>
<body>

	<%@ include file="../common/menubar.jsp" %>
	
	<!-- ==================== 사이드바 ==================== -->
	<aside>

		<!-- ------- 대분류: ex) 공유주소록, 개인주소록 ------- -->
		<div class="big-cate">

			<h2 class="big-cate__title">
				공유 주소록
				<a href="">
					<span class="material-symbols-rounded icon">add</span>
				</a>
			</h2>

			<ul class="big-cate__contents">

				<!-- ------- 중분류: ex) 세미프로젝트 ------- -->
				<li class="mid-cate">
					<div class="mid-cate__title active">
						<div>
							<span class="material-icons-round icon people">people</span>
							<span>모든 사용자</span>
							<span class="userCount">(24)</span>
						</div>
					</div>
				</li>

				<!-- ------- 중분류: ex) 세미프로젝트 ------- -->
				<li class="mid-cate">

					<div class="mid-cate__title">
						<div>
							<span class="material-icons-round icon people">people</span>
							<span class="title">자바 미니 팀프로젝트</span>
							<span class="material-symbols-rounded icon fold">keyboard_arrow_down</span>
						</div>
						<div>
							<span class="material-symbols-rounded icon edit">edit</span>
						</div>
					</div>

					<ul class="mid-cate__contents hidden">

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>1조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>2조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>3조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>4조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>5조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

					</ul> <!-- .mid-cate__contents -->
				</li> <!-- .mid-cate ------- 중분류: ex) 세미프로젝트 ------- -->
				
				<!-- ------- 중분류: ex) 세미프로젝트 ------- -->
				<li class="mid-cate">

					<div class="mid-cate__title">
						<div>
							<span class="material-icons-round icon people">people</span>
							<span class="title">웹 클론 프로젝트</span>
							<span class="material-symbols-rounded icon fold">keyboard_arrow_down</span>
						</div>
						<div>
							<span class="material-symbols-rounded icon edit">edit</span>
						</div>
					</div>

					<ul class="mid-cate__contents hidden">

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>1조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>2조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>3조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>4조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>5조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

					</ul> <!-- .mid-cate__contents -->
				</li> <!-- .mid-cate ------- 중분류: ex) 세미프로젝트 ------- -->

				<!-- ------- 중분류: ex) 세미프로젝트 ------- -->
				<li class="mid-cate">

					<div class="mid-cate__title">
						<div>
							<span class="material-icons-round icon people">people</span>
							<span class="title">세미 프로젝트</span>
							<span class="material-symbols-rounded icon fold">keyboard_arrow_down</span>
						</div>
						<div>
							<span class="material-symbols-rounded icon edit">edit</span>
						</div>
					</div>

					<ul class="mid-cate__contents hidden">

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>1조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>2조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>3조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>4조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>5조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

					</ul> <!-- .mid-cate__contents -->
				</li> <!-- .mid-cate ------- 중분류: ex) 세미프로젝트 ------- -->

				<!-- ------- 중분류: ex) 세미프로젝트 ------- -->
				<li class="mid-cate">

					<div class="mid-cate__title">
						<div>
							<span class="material-icons-round icon people">people</span>
							<span class="title">파이널 프로젝트</span>
							<span class="material-symbols-rounded icon fold">keyboard_arrow_down</span>
						</div>
						<div>
							<span class="material-symbols-rounded icon edit">edit</span>
						</div>
					</div>

					<ul class="mid-cate__contents hidden">

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>1조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>2조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>3조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>4조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

						<!-- ------- 소분류: ex) 2조 ------- -->
						<li class="sm-cate">
							<div>
								<span class="material-icons icon">subdirectory_arrow_right</span>
								<span>5조</span>
								<span class="userCount">(6)</span>
							</div>
						</li>

					</ul> <!-- .mid-cate__contents -->
				</li> <!-- .mid-cate ------- 중분류: ex) 세미프로젝트 ------- -->

				<!-- ------- 중분류: ex) 세미프로젝트 ------- -->
				<li class="mid-cate">

					<div class="mid-cate__title">
						<div>
							<span class="material-icons-round icon people">people</span>
							<span class="title">자격증 스터디</span>
						</div>
						<div>
							<span class="material-symbols-rounded icon edit">edit</span>
						</div>
					</div>

				</li> <!-- .mid-cate ------- 중분류: ex) 세미프로젝트 ------- -->

			</ul> <!-- .big-cate__contents -->
		</div> <!-- .big-cate ------- 대분류: ex) 공유주소록, 개인주소록 ------- -->

		<!-- ------- 대분류: ex) 공유주소록, 개인주소록 ------- -->
		<div class="big-cate">

			<h2 class="big-cate__title">
				개인 주소록
				<a href="">
					<span class="material-symbols-rounded icon">add</span>
				</a>
			</h2>

			<ul class="big-cate__contents">

				<!-- ------- 중분류: ex) 세미프로젝트 ------- -->
				<li class="mid-cate">
					<div class="mid-cate__title">
						<div>
							<span class="material-icons-round icon people">people</span>
							<span>기본 주소록 1</span>
							<span class="userCount">(3)</span>
						</div>
						<div>
							<span class="material-symbols-rounded icon edit">edit</span>
						</div>
					</div>
				</li>

				<!-- ------- 중분류: ex) 세미프로젝트 ------- -->
				<li class="mid-cate">
					<div class="mid-cate__title">
						<div>
							<span class="material-icons-round icon people">people</span>
							<span>기본 주소록 2</span>
							<span class="userCount">(3)</span>
						</div>
						<div>
							<span class="material-symbols-rounded icon edit">edit</span>
						</div>
					</div>
				</li>

			</ul> <!-- .big-cate__contents -->
		</div> <!-- .big-cate ------- 대분류: ex) 공유주소록, 개인주소록 ------- -->

	</aside>

	<!-- ==================== 메인 컨텐츠 ==================== -->
	<main>
		<!-- ------- 검색창 섹션 (section__serach-bar) ------- -->
		<section class="section__serach-bar">

			<div class="btn-group">
				<button>공유 주소록에 추가</button>
				<button>내 주소록에 추가</button>
				<button>
					<span class="material-symbols-outlined icon">mail</span>
					<span>메일</span>
				</button>
			</div>

			<div class="search-bar">
				<input type="text" name="keyword" placeholder="검색어를 입력해주세요.">
				<span class="material-symbols-outlined icon">search</span>
			</div>

			<div class="search-options">
				<input type="checkbox" id="search-by-userName" name="search-option">
				<label for="search-by-userName">이름</label>

				<input type="checkbox" id="search-by-userId" name="search-option">
				<label for="search-by-userId">아이디</label>

				<input type="checkbox" id="search-all-students" name="search-option">
				<label for="search-all-students">학생</label>
			</div>
		</section>

		<!-- 목록 헤더 섹션 (section__list-header) -->
		<section class="section__list-header">

			<div class="checkbox">
				<input type="checkbox" name="" id="">
			</div>

			<div class="star">
				<span class="material-icons-round icon star-icon fill">star</span>
				<span class="material-symbols-rounded icon">arrow_drop_down</span>
			</div>

			<div class="userName">
				이름
				<span class="material-symbols-rounded icon">arrow_drop_down</span>
			</div>
			<div class="userId">
				아이디
				<span class="material-symbols-rounded icon">arrow_drop_down</span>
			</div>
			<div class="role">
				역할
				<span class="material-symbols-rounded icon">arrow_drop_down</span>
			</div>
			<div class="birthday">
				생일
				<span class="material-symbols-rounded icon">arrow_drop_down</span>
			</div>
			<div class="phone">
				연락처
				<span class="material-symbols-rounded icon">arrow_drop_down</span>
			</div>
		</section>

		<!-- 목록 섹션 (section__list) -->
		<section class="section__list">
			<ul>

				<!-- 한 줄의 사용자 데이터 -->
				<li>
					<div class="checkbox">
						<input type="checkbox" name="" id="">
					</div>
					
					<div class="star">
						<span class="material-symbols-rounded icon star-icon">star</span>
					</div>

					<div class="userName">
						<span class="material-symbols-rounded icon profile-pic">account_circle</span>
						나관리
					</div>

					<div class="userId">admin</div>
					<div class="role">선생님</div>
					<div class="birthday">1월 23일</div>
					<div class="phone">010-1111-2222</div>
				</li>

			</ul>
		</section>


		
	</main>
	
</body>
</html>