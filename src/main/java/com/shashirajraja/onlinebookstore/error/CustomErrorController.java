package com.shashirajraja.onlinebookstore.error;

import java.io.PrintWriter;
import java.io.StringWriter;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping(value = "/error", produces = "text/html")
    public ModelAndView handleErrorHtml(HttpServletRequest request) {
        Object e = request.getAttribute("javax.servlet.error.exception");
        Throwable ex = null;
        if (e instanceof Throwable) ex = (Throwable) e;

        ModelAndView mav = new ModelAndView("error");
        mav.addObject("errorMessage", "Ha ocurrido un error inesperado");

        if (ex != null) {
            StringWriter sw = new StringWriter();
            ex.printStackTrace(new PrintWriter(sw));
            mav.addObject("errorDetails", ex.toString() + "\n" + sw.toString());
        } else {
            Object msg = request.getAttribute("javax.servlet.error.message");
            mav.addObject("errorDetails", msg != null ? msg.toString() : "Sin detalles disponibles");
        }

        Object uri = request.getAttribute("javax.servlet.error.request_uri");
        mav.addObject("url", uri != null ? uri.toString() : request.getRequestURI());
        return mav;
    }
}
