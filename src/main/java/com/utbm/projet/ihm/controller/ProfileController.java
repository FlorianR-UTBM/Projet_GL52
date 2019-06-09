/*
 * Projet GL52
 *
 * FENG Shunli - GRAF Pierrick - RIFFLART Florian
 *
 * UTBM P2019
 */
package com.utbm.projet.ihm.controller;

import com.utbm.projet.dao.data.Utilisateur;
import com.utbm.projet.dao.interf.UserAuthDao;
import com.utbm.projet.dao.interf.UserDao;
import com.utbm.projet.ihm.model.ProfileModel;
import com.utbm.projet.ihm.model.TemplateModel;
import java.util.Arrays;
import java.util.List;
import javax.annotation.ManagedBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;

/**
 * Controller class of the Profile page.
 */
@ManagedBean
@Scope("session")
public class ProfileController extends GenericController {

    @Autowired
    private ProfileModel profileModel;

    @Autowired
    private TemplateModel templateModel;

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserAuthDao userAuthDao;

    @Override
    public void initModel() {
        Long userId = templateModel.getUser().getId();
        Utilisateur user = userDao.getByUserAuthId(userId);

        if (user != null) {
            profileModel.setFirstname(user.getPrenomUtilisateur());
            profileModel.setLastname(user.getNomUtilisateur());
            profileModel.setEmail(user.getCourrielUtilisateur());
            profileModel.setAddress(user.getAdresseUtilisateur());

            profileModel.setAge(user.getAge());
            profileModel.setWeight(user.getPoids());
            profileModel.setHeight(user.getTaille());

            if (user.getAllergies() != null) {
                profileModel.setAllergies(Arrays.asList(user.getAllergies().split(";")));
            }

            if (user.getCarences() != null) {
                profileModel.setDeficiencies(Arrays.asList(user.getCarences().split(";")));
            }
        }
    }

    public void updateUser() {

        Long userId = templateModel.getUser().getId();
        Utilisateur user = userDao.getByUserAuthId(userId);

        user.setId(userAuthDao.getById(userId));
        user.setPrenomUtilisateur(profileModel.getFirstname());
        user.setNomUtilisateur(profileModel.getLastname());
        user.setCourrielUtilisateur(profileModel.getEmail());
        user.setAdresseUtilisateur(profileModel.getAddress());

        user.setAge(profileModel.getAge());
        user.setPoids(profileModel.getWeight());
        user.setTaille(profileModel.getHeight());

        List<String> allergiesList = profileModel.getAllergies();
        String allergies = "";

        for (int i = 0; i < allergiesList.size(); i++) {
            allergies += allergiesList.get(i);

            if (i < allergiesList.size() - 1) {
                allergies += ";";
            }
        }
        user.setAllergies(allergies);

        List<String> deficienciesList = profileModel.getDeficiencies();
        String deficiencies = "";
        for (int i = 0; i < deficienciesList.size(); i++) {
            deficiencies += deficienciesList.get(i);

            if (i < deficienciesList.size() - 1) {
                deficiencies += ";";
            }
        }
        user.setCarences(deficiencies);

        userDao.update(user);
    }
}
