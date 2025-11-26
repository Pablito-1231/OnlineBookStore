package com.shashirajraja.onlinebookstore.email;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import com.shashirajraja.onlinebookstore.service.EmailService;

/**
 * Test para verificar la funcionalidad del servicio de email
 */
@SpringBootTest
public class EmailServiceTest {

    @Autowired
    private EmailService emailService;
    
    @Autowired
    private JavaMailSender mailSender;

    @Test
    public void testEmailConfiguration() {
        System.out.println("=== TEST DE CONFIGURACIÓN DE EMAIL ===");
        System.out.println("JavaMailSender configurado: " + (mailSender != null ? "✅ SÍ" : "❌ NO"));
        System.out.println("EmailService configurado: " + (emailService != null ? "✅ SÍ" : "❌ NO"));
    }

    /**
     * Test para enviar un email de prueba
     * NOTA: Este test intentará enviar un email real
     */
    @Test
    public void testSendSimpleEmail() {
        try {
            System.out.println("\n=== ENVIANDO EMAIL DE PRUEBA ===");
            
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("libreriarefugioliterario8@gmail.com");
            message.setTo("libreriarefugioliterario8@gmail.com"); // Enviar a ti mismo
            message.setSubject("✅ Test de Email - OnlineBookStore");
            message.setText("¡Hola!\n\nEste es un email de prueba del sistema OnlineBookStore.\n\n" +
                          "Si recibes este mensaje, significa que la configuración de correo está funcionando correctamente.\n\n" +
                          "Fecha: " + new java.util.Date() + "\n\n" +
                          "Saludos,\nSistema OnlineBookStore");
            
            mailSender.send(message);
            
            System.out.println("✅ Email enviado exitosamente a: libreriarefugioliterario8@gmail.com");
            System.out.println("📧 Revisa tu bandeja de entrada (o spam)");
            
        } catch (Exception e) {
            System.err.println("❌ ERROR al enviar email: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Test para enviar emails de prueba a Vanessa y Barreto
     */
    @Test
    public void testSendEmailToVanessa() {
        try {
            System.out.println("\n=== ENVIANDO EMAILS DE PRUEBA ===");
            
            // Email a Vanessa
            SimpleMailMessage messageVanessa = new SimpleMailMessage();
            messageVanessa.setFrom("libreriarefugioliterario8@gmail.com");
            messageVanessa.setTo("Vanetorresm.1809@gmail.com");
            messageVanessa.setSubject("🎉 Prueba OnlineBookStore - Sistema de Email");
            messageVanessa.setText("¡Hola Vanessa!\n\n" +
                          "Este es un email de prueba enviado desde el sistema OnlineBookStore.\n\n" +
                          "La funcionalidad de envío de correos está funcionando correctamente.\n\n" +
                          "Detalles del test:\n" +
                          "- Sistema: OnlineBookStore v0.0.1\n" +
                          "- Fecha: " + new java.util.Date() + "\n" +
                          "- Servidor SMTP: Gmail (libreriarefugioliterario8@gmail.com)\n\n" +
                          "Saludos,\n" +
                          "Sistema OnlineBookStore");
            
            mailSender.send(messageVanessa);
            System.out.println("✅ Email enviado exitosamente a: Vanetorresm.1809@gmail.com");
            
            // Email a Barreto
            SimpleMailMessage messageBarreto = new SimpleMailMessage();
            messageBarreto.setFrom("libreriarefugioliterario8@gmail.com");
            messageBarreto.setTo("barretopabloandres@gmail.com");
            messageBarreto.setSubject("🎉 Prueba OnlineBookStore - Sistema de Email");
            messageBarreto.setText("¡Hola Barreto!\n\n" +
                          "Este es un email de prueba enviado desde el sistema OnlineBookStore.\n\n" +
                          "La funcionalidad de envío de correos está funcionando correctamente.\n\n" +
                          "Detalles del test:\n" +
                          "- Sistema: OnlineBookStore v0.0.1\n" +
                          "- Fecha: " + new java.util.Date() + "\n" +
                          "- Servidor SMTP: Gmail (libreriarefugioliterario8@gmail.com)\n\n" +
                          "Saludos,\n" +
                          "Sistema OnlineBookStore");
            
            mailSender.send(messageBarreto);
            System.out.println("✅ Email enviado exitosamente a: barretopabloandres@gmail.com");
            
            System.out.println("📧 Ambos destinatarios deberían recibir el email en breve (revisar spam si no llega)");
            
        } catch (Exception e) {
            System.err.println("❌ ERROR al enviar email: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Test para enviar emails de prueba a Juan y Danilo
     */
    @Test
    public void testSendEmailsToJuanAndDanilo() {
        try {
            System.out.println("\n=== ENVIANDO EMAILS A JUAN Y DANILO ===");

            // Email a Juan
            SimpleMailMessage msgJuan = new SimpleMailMessage();
            msgJuan.setFrom("libreriarefugioliterario8@gmail.com");
            msgJuan.setTo("juanpfabra@gmail.com");
            msgJuan.setSubject("📚 Prueba OnlineBookStore - Email de Verificación");
            msgJuan.setText("¡Hola Juan!\n\n" +
                    "Este es un correo de prueba enviado desde OnlineBookStore para verificar el envío de emails.\n\n" +
                    "Fecha: " + new java.util.Date() + "\n" +
                    "Remitente: libreriarefugioliterario8@gmail.com\n\n" +
                    "Saludos,\nSistema OnlineBookStore");
            mailSender.send(msgJuan);
            System.out.println("✅ Email enviado a: juanpfabra@gmail.com");

            // Email a Danilo
            SimpleMailMessage msgDanilo = new SimpleMailMessage();
            msgDanilo.setFrom("libreriarefugioliterario8@gmail.com");
            msgDanilo.setTo("daniloblanco013@gmail.com");
            msgDanilo.setSubject("📚 Prueba OnlineBookStore - Email de Verificación");
            msgDanilo.setText("¡Hola Danilo!\n\n" +
                    "Este es un correo de prueba enviado desde OnlineBookStore para verificar el envío de emails.\n\n" +
                    "Fecha: " + new java.util.Date() + "\n" +
                    "Remitente: libreriarefugioliterario8@gmail.com\n\n" +
                    "Saludos,\nSistema OnlineBookStore");
            mailSender.send(msgDanilo);
            System.out.println("✅ Email enviado a: daniloblanco013@gmail.com");

            System.out.println("📧 Ambos deberían recibir el correo en minutos (revisar spam)");
        } catch (Exception e) {
            System.err.println("❌ ERROR al enviar emails: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
