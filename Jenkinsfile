node{
   stage('SCM Checkout'){
     git 'https://github.com/alhaj1986/my-app.git'
   }
   stage('Compile-Package'){

      def mvnHome =  tool name: 'maven3', type: 'maven'   
      sh "${mvnHome}/bin/mvn clean package"
	  sh 'mv target/myweb*.war target/newapp.war'
   }
     stage('Build Docker Imager'){
   sh 'docker build -t alhaj1986/myweb:0.0.2 .'
   }
   stage('Docker Image Push'){
   withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
   sh "docker login -u alhaj1986 -p ${dockerPassword}"
    }
   sh 'docker push alhaj1986/myweb:0.0.2'
   }
   
   stage('Remove Previous Container'){
	try{
		sh 'docker rm -f tomcattest'
	}catch(error){
		//  do nothing if there is an exception with this
	}
   stage('Docker deployment'){
   sh 'docker run -d -p 8090:8080 --name tomcattest alhaj1986/myweb:0.0.2' 
   }
}
}
