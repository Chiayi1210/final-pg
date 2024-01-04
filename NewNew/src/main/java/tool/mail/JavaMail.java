package tool.mail;
import java.util.Objects;
import java.util.Properties;

import javax.activation.DataSource;
import javax.activation.FileDataSource;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.activation.DataHandler;

public class JavaMail {
	// ---------------------------------------------------------基本資料
	private String userName = "study102114236@gmail.com";
    private String password = "yjnuzcdyiogqncss";
    private String customer = Objects.toString(getCustomer(), "");
    private String subject = Objects.toString(getSubject(), "");
    private String txt = Objects.toString(getTxt(), "");

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTxt() {
        return txt;
    }

    public void setTxt(String txt) {
        this.txt = txt;
    }

    public void SendMail() {
        try {
            // 檢查郵件地址是否為空
            if (customer == null || customer.isEmpty()) {
                System.err.println("Error: Recipient email address is null or empty.");
                return;
            }

            // 設置連線屬性
            Properties prop = new Properties();
            prop.setProperty("mail.transport.protocol", "smtp");
            prop.setProperty("mail.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "465");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            prop.put("mail.smtp.socketFactory.port", "465");
            prop.put("mail.debug", "true");

            // 設置驗證
            Session session = Session.getDefaultInstance(prop, new Auth(userName, password));

            // 設置郵件格式
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(userName));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(customer));
            message.setSubject(subject);
            message.setContent(txt, "text/html;charset=UTF-8");

            // 發送郵件
            Transport.send(message);

            System.out.println("Sent message successfully.");
        } catch (MessagingException e) {
            System.err.println("Error while sending email:");
            e.printStackTrace();
        }
    }
}

class Auth extends Authenticator {

    private String userName;
    private String password;

    public Auth(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(userName, password);
    }
}
