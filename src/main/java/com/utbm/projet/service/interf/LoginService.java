/*
 * Projet GL52
 *
 * FENG Shunli - GRAF Pierrick - RIFFLART Florian
 *
 * UTBM P2019
 */
package com.utbm.projet.service.interf;

import com.utbm.projet.dao.data.UserAuth;

/**
 * Service class for login.
 */
public interface LoginService {

    /**
     * Returns the user for the specified username and password.
     *
     * @param username the specified username.
     * @param password the specified password.
     * @return
     */
    public UserAuth login(String username, String password);

    /**
     * Registers and returns a new user for the specified username and password.
     *
     * @param username the specified username.
     * @param password the specified password.
     * @return
     */
    public UserAuth register(String username, String password);

}
