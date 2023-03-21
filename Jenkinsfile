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
   sh 'docker build -t alhaj1986/myweb:0.0.6 .'
   }
   stage('Docker Image Push'){
   withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
   sh "docker login -u alhaj1986 -p ${dockerPassword}"
    }
   sh 'docker push alhaj1986/myweb:0.0.6'
   }
    stage('Nexus Image Push'){
   sh "docker login -u admin -p admin123 13.127.125.125:8083"
   sh "docker tag alhaj1986/myweb:0.0.6 13.127.125.125:8083/demo:1.0.0"
   sh 'docker push 13.127.125.125:8083/demo:1.0.0'
   }
  
   stage('Remove Previous Container'){
	try{
		sh 'docker rm -f tomcattest'
	}catch(error){
		//  do nothing if there is an exception only
	}
   stage('Docker deployment'){
   sh 'docker run -d -p 8090:8080 --name tomcattest alhaj1986/myweb:0.0.6' 
   }
}
}
