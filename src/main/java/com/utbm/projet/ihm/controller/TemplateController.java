/*
 * Projet GL52
 *
 * FENG Shunli - GRAF Pierrick - RIFFLART Florian
 *
 * UTBM P2019
 */
package com.utbm.projet.ihm.controller;

import com.utbm.projet.dao.data.UserAuth;
import com.utbm.projet.ihm.model.TemplateModel;
import com.utbm.projet.service.interf.LoginService;
import java.io.IOException;
import javax.annotation.ManagedBean;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import org.primefaces.PrimeFaces;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;

/**
 * Controller class for the template of each pages.
 */
@ManagedBean
@Scope("session")
public class TemplateController extends GenericController {

    @Autowired
    private TemplateModel templateModel;

    @Autowired
    private ProfileController profileController;

    @Autowired
    private HomeController homeController;

    @Autowired
    private LoginService loginService;

    @Override
    public void initModel() {
        templateModel.setUserAuth(new UserAuth());
    }

    /**
     * Checks the login credentials.
     */
    public void login() throws IOException {
        FacesMessage message = null;

        String pseudo = templateModel.getUserAuth().getPseudo();
        String password = templateModel.getUserAuth().getMdp();

        try {
            UserAuth userAuth = loginService.login(pseudo, password);

            templateModel.setLogged(true);
            templateModel.setUserAuth(userAuth);

            profileController.initModel();
            homeController.initModel();

            message = new FacesMessage(FacesMessage.SEVERITY_INFO, "Bienvenue", pseudo);
        } catch (Exception e) {
            templateModel.setLogged(false);
            message = new FacesMessage(FacesMessage.SEVERITY_ERROR, "Erreur d'authentification", "Informations d'authentification invalides");
        } finally {
            FacesContext.getCurrentInstance().addMessage("loginForm", message);
            PrimeFaces.current().ajax().addCallbackParam("loggedIn", templateModel.isLogged());
        }
    }

    public void register() {
        FacesMessage message = null;

        String pseudo = templateModel.getUserAuth().getPseudo();
        String password = templateModel.getUserAuth().getMdp();

        try {
            UserAuth user = loginService.register(pseudo, password);

            templateModel.setLogged(true);
            templateModel.getUserAuth().setId(user.getId());
            templateModel.getUserAuth().setAccountType(user.getAccountType());

            message = new FacesMessage(FacesMessage.SEVERITY_INFO, "Inscription réussie", "");
        } catch (Exception e) {
            message = new FacesMessage(FacesMessage.SEVERITY_WARN, "Erreur d'inscription", e.getCause().getMessage());
        } finally {
            FacesContext.getCurrentInstance().addMessage("registerForm", message);
            PrimeFaces.current().ajax().addCallbackParam("loggedIn", templateModel.isLogged());
        }
    }

    /**
     * Disconnects the user.
     *
     * @throws java.io.IOException
     */
    public void signOut() throws IOException {
        templateModel.setLogged(false);
    }

    /**
     * Displays the login dialog.
     *
     * @throws java.io.IOException
     */
    public void signIn() throws IOException {
        PrimeFaces.current().executeScript("PF('dlgLogin').show();");
    }

    /**
     * Displays the sign up dialog.
     *
     * @throws IOException
     */
    public void signUp() throws IOException {
        PrimeFaces.current().executeScript("PF('dlgRegister').show();");
    }
}
