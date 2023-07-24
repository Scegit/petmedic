package com.spring.pet.users;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class MailSendService {
    @Autowired
    private JavaMailSenderImpl mailSender;

    //이메일 보낼 양식!
    public String joinEmail(String email, String authCode) {
        String setFrom = "java.jjang.1212@gmail.com"; // email-config에 설정한 자신의 이메일 주소를 입력
        String toMail = email;
        System.out.println("email : " + email);
        String title = "회원 가입 인증 이메일 입니다."; // 이메일 제목
        String content =
                "홈페이지를 방문해주셔서 감사합니다." +    //html 형식으로 작성 !
                        "<br><br>" +
                        "인증 번호는 " + authCode + "입니다." +
                        "<br>" +
                        "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
        mailSend(setFrom, toMail, title, content);
        return authCode;
    }

    //이메일 전송 메소드
    public void mailSend(String setFrom, String toMail, String title, String content) {
        System.out.println("mailSend메소드 탔음? ");
        MimeMessage message = mailSender.createMimeMessage();
        // true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.
        try {
            System.out.println("mailSend메소드 try문탔음?22 ");
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            System.out.println("setFrom : " + setFrom);
            helper.setFrom(setFrom);
            System.out.println("toMail : " + toMail);
            helper.setTo(toMail);
            System.out.println("title : " + title);
            helper.setSubject(title);
            System.out.println("content : " + content);
            // true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
            helper.setText(content, true);
            mailSender.send(message);
            System.out.println("mailSend메소드 try문탔음?33 ");
        } catch (MessagingException e) {
            System.out.println("mailSend메소드 catch문탔음? ->아이디 아무것도 안치면 오류라 이거 뜨고");
            e.printStackTrace();
        }
    }

  //마이페이지 이메일 보낼 양식
    public String updateEmail(String email, String authCode) {
        String setFrom = "java.jjang.1212@gmail.com"; // email-config에 설정한 자신의 이메일 주소를 입력
        String toMail = email;
        System.out.println("email : " + email);
        String title = "본인확인 인증 이메일 입니다."; // 이메일 제목
        String content =
                "홈페이지를 방문해주셔서 감사합니다." +    //html 형식으로 작성 !
                        "<br><br>" +
                        "인증 번호는 " + authCode + "입니다." +
                        "<br>" +
                        "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; //이메일 내용 삽입
        mailSend(setFrom, toMail, title, content);
        return authCode;
    }
}