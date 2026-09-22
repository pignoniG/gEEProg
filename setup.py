#!/usr/bin/env python3

from setuptools import setup

setup(
    name='gEEProg',
    version='2.2.0',
    package_dir={'': 'src'},
    py_modules=['gEEProg'],
    python_requires='>=3.8',
    install_requires=['pyserial>=3.0'],
    author='Mark Chilenski',
    author_email='mark.chilenski@gmail.com',
    url='http://www.dasarodesigns.com/',
    description="GUI to control D'Asaro Designs EEPROM programmers.",
    long_description=open('README.rst', 'r').read(),
    long_description_content_type='text/x-rst',
    license='GPL',
    scripts=['src/gEEProgGUI'],
    data_files=[('data/gEEProg', ['graphics/Icon.gif'])]
)
