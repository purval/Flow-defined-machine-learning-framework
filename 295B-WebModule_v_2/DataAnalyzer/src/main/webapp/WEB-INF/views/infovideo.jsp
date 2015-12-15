<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		video#bgvid { 
		    position: fixed;
		    top: 50%;
		    left: 50%;
		    min-width: 100%;
		    min-height: 100%;
		    width: auto;
		    height: auto;
		    z-index: -100;
		    -webkit-transform: translateX(-50%) translateY(-50%);
		    transform: translateX(-50%) translateY(-50%);
		    background: url(polina.jpg) no-repeat;
		    background-size: cover; 
		}
	</style>
</head>
<body>
<video autoplay loop id="bgvid">
    <source src="./resources/images/project_demo.mp4" type="video/mp4">
</video>
</body>
</html>