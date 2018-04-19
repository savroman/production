import hudson.model.JDK
import hudson.tools.InstallSourceProperty
import hudson.tools.ZipExtractionInstaller
def descriptor = new JDK.DescriptorImpl();

def List<JDK> installations = []

javaTools=['name':'jdk8', 'url':'http://repo.if083/soft/jdk-8u172-linux-x64.tar.gz', 'subdir':'jdk1.8.0_172']

println("Setting up tool: ${javaTool.name}")
def installer = new ZipExtractionInstaller(javaTool.label as String, javaTool.url as String, javaTool.subdir as String);
def jdk = new JDK(javaTool.name as String, null, [new InstallSourceProperty([installer])])
installations.add(jdk)

descriptor.setInstallations(installations.toArray(new JDK[installations.size()]))
descriptor.save()
