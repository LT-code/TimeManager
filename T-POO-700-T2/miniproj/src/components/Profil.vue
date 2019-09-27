<template>
	<div>
        <router-link></router-link>
		<head>
			<title>Profil Page</title>
			<!--Fontawesome CDN-->
			<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
		</head>
		<div class="container">
			<div>
				
				<div class="card">
					<form>
						<div class="card-body">
							<h3>Edit Profile</h3>
                            <div class ="tailleinput">
                            <div>
                                <div class="input-group-prepend">
                                    <label> FIRST NAME </label>
                                 </div>
                                 <input type="text" class="form-control" placeholder="first name" v-model="first_name">
                            </div>
                            
                                <div class="input-group-prepend">
                                    <label> LAST NAME </label>
                                </div>
                                <input type="text" class="form-control" placeholder="Last name" v-model="Last_name">
                            </div>
							<div>
								<div class="input-group-prepend">
									<label> EMAIL </label>
								</div>
                            
								<input type="text" class="form-control" placeholder="email" v-model="user_email">
                            </div>
                            </div>
							
							<div class="form-group">
								<input type="button" value="Update Profil" class="btn float-right login_btn" >
							</div>
                    </form>
				</div>

				</div>
			</div>
		</div>
	</div>
</template>
<style>

@import 'Profil.css';
</style>
