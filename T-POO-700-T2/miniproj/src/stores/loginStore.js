import Vue from 'vue'
import Vuex from 'vuex';
import axios from 'axios';

Vue.use(Vuex);

const state = {
	loading: false,
	loginError: '',
	loginSuccessful: false
};

const mutations = {
	LOGIN_START: state => state.loading = true,
	LOGIN_STOP: (state, errorMessage) => {
		state.loading = false;
		if (errorMessage !== null) {
			state.loginError = errorMessage;
			state.loginSuccessful = false;
		} else {
			state.loginSuccessful = true;
		}
	}
};

const actions = {
	getLoggedIn(store, loginData) {
		store.commit('LOGIN_START');
		axios.post('https://reqres.in/api/login', { ...loginData })
			.then(() => {
				store.commit('LOGIN_STOP', null);
			})
			.catch(error => {
				store.commit('LOGIN_STOP', error.response.data.error);
			})
	}
};

export default new Vuex.Store({
	state: state,
	getters: {},
	mutations: mutations,
	actions: actions
});