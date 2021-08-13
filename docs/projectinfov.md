---
layout: default
title: Project Infrastructure Overview
has_children: true
has_toc: false
nav_order: 2
---
# Project Infrastructure Overview
Here we give an overview of the infrastructure used in this project.

For this project, we want to use data collected from people’s mobile devices to learn more about affect, mood, the brain, and behaviour. To accomplish this, we need some way to both passively and actively collect data from their phones safely, efficiently, and with their permission. We already have a very fruitful example of how this can be done and what we can learn, from <a href="https://www.biorxiv.org/content/10.1101/2021.05.17.444568v1">Cedric Xia’s 2021 publication.</a>


The solution for this project was initially developed by <a href="http://www.wwbp.org/">Lyle Unghar’s group</a> at the University of Pennsylvania. Much of this project borrows their infrastructure, and so this documentation serves as a replication guide for how to set up the software architecture for a mobile phenotyping project. 

The components are as follows:

1. The AWARE Framework
2. An accompanying Amazon EC2 Instance
3. An accompanying AWARE backend server
4. Your local data analysis framework and RAPIDS